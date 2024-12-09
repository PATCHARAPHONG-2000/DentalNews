import 'dart:io';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Firebase/FireBase.dart';
import '../../Firebase/Knowledge.dart';

class NewKnowledge extends StatefulWidget {
  const NewKnowledge({super.key});

  @override
  State<NewKnowledge> createState() => _NewKnowledgeState();
}

class _NewKnowledgeState extends State<NewKnowledge> {
  List<Widget> knowledgewidgests = [];
  Map<String, bool> viewedItems = {}; // Track viewed items

  @override
  void initState() {
    super.initState();
    loadViewedItems();
    fetchData();
  }

  Future<void> loadViewedItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        viewedItems = prefs.getKeys().fold<Map<String, bool>>({}, (map, key) {
          map[key] = prefs.getBool(key) ?? false;
          return map;
        });
      });
    } catch (e) {
      // จัดการกรณีที่เกิดข้อผิดพลาดในการดึงข้อมูลจาก SharedPreferences
      print("Error loading viewed items: $e");
    } finally {
      fetchData(); // Fetch data หลังจากโหลดข้อมูลการดูแล้ว
    }
  }

  Future<void> markAsViewed(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(id, true); // บันทึกสถานะการดูแล้ว
    setState(() {
      viewedItems[id] = true;
    });
  }

  Future<void> fetchData() async {
    List<NewKnowledg> newKnowledgDataList = await FireBaseData.knowledgData();

    // จัดเรียงไอเท็ม โดยไอเท็มที่ยังไม่ถูกดูจะแสดงก่อน
    newKnowledgDataList.sort((a, b) {
      bool aIsNew = viewedItems[a.id] != true;
      bool bIsNew = viewedItems[b.id] != true;

      if (aIsNew && !bIsNew) return -1; // a ใหม่กว่า b
      if (!aIsNew && bIsNew) return 1; // b ใหม่กว่า a
      return 0; // ถ้าทั้งสองเหมือนกัน ให้เรียงตามลำดับเดิม
    });

    setState(() {
      knowledgewidgests = newKnowledgDataList
          .map((newKnowledg) => knowledgeWidget(newKnowledg))
          .toList();
    });
  }

  Future<void> downloadAndOpenPDF(String url, String fileName) async {
    try {
      final shortFileName =
          fileName.hashCode.toString(); // ใช้ hashCode แทนชื่อไฟล์
      final directory = await getApplicationDocumentsDirectory();
      final path = directory.path;
      final filePath = '$path/$shortFileName.pdf';

      final file = File(filePath);
      if (!await file.exists()) {
        final response = await HttpClient().getUrl(Uri.parse(url));
        final fileStream = await response.close();
        await fileStream.pipe(file.openWrite());
      }

      final result = await OpenFile.open(filePath);
      if (result.type == ResultType.error) {
        print("ไม่สามารถเปิดไฟล์ได้: ${result.message}");
      }
    } catch (e) {
      print('เกิดข้อผิดพลาด: $e');
    }
  }

  Widget knowledgeWidget(NewKnowledg newknowledge) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  markAsViewed(newknowledge.id);
                  downloadAndOpenPDF(
                    newknowledge.pdfUrl,
                    newknowledge.name,
                  );
                },
                splashColor: Theme.of(context).primaryColor,
                highlightColor: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width *
                      1.0, // Responsive width
                  height: MediaQuery.of(context).size.height *
                      0.25, // Responsive height
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(newknowledge.coverUrl),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Theme.of(context).focusColor,
                      width: MediaQuery.of(context).size.width *
                          0.002, // Responsive border width
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.03,
                ),
                child: Text(
                  newknowledge.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.k2d(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width *
                        0.05, // Responsive font size
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.03,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.black,
                      size: MediaQuery.of(context).size.width *
                          0.04, // Responsive icon size
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        'ผู้เขียน: ${newknowledge.author}',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.k2d(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width *
                                0.04, // Responsive font size
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.03,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                      size: MediaQuery.of(context).size.width *
                          0.04, // Responsive icon size
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'วันที่: ${newknowledge.time}',
                      style: GoogleFonts.k2d(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width *
                            0.04, // Responsive font size
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          tr('app.knowledge'),
          style: GoogleFonts.k2d(
            textStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(LineIcons.chevronCircleLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('image/rb_17580.png'), // Add background image
            fit: BoxFit.cover,
          ),
        ),
        child: knowledgewidgests.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).hoverColor,
                ),
              )
            : ListView.builder(
                itemCount: knowledgewidgests.length,
                itemBuilder: (context, index) {
                  return knowledgewidgests[index];
                },
              ),
      ),
    );
  }
}
