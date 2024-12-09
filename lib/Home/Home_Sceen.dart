import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalnews/Home/chat_bot/chat_screen.dart';
import 'package:dentalnews/Widget/Knowledge/Knowledge.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Firebase/Knowledge.dart';
import '../Model/Home_Model.dart';
import '../Model/ImageSlide.dart';
import '../Model/drawer_screen.dart';

class HomeSceen extends StatefulWidget {
  final String title;
  const HomeSceen({super.key, required this.title});

  @override
  State<HomeSceen> createState() => _HomeSceenState();
}

class _HomeSceenState extends State<HomeSceen> {
  List<Widget> knowledgewidgests = [];
  bool isLoading = false; // สถานะการโหลด

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // ดึงข้อมูลการดูจาก SharedPreferences
  Future<bool> _hasViewed(String knowledgeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(knowledgeId) ?? false;
  }

  // บันทึกข้อมูลการดูลง SharedPreferences
  Future<void> _markAsViewed(String knowledgeId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(knowledgeId, true);
  }

  Future<void> fetchData() async {
    // ดึงข้อมูลจาก Firestore และจำกัดแค่ 5 รายการ
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Dental_Knowledge_news')
        .orderBy('timestamp', descending: true)
        .limit(5)
        .get();

    // แปลงเอกสาร Firestore เป็น List ของ NewKnowledg objects
    List<NewKnowledg> careDataList = snapshot.docs.map((doc) {
      return NewKnowledg.fromMap(
          doc.data() as Map<String, dynamic>, doc.id); // ส่งต่อ doc.id
    }).toList();

    // อัปเดต state
    setState(() {
      knowledgewidgests = careDataList
          .map((newKnowledg) => knowledgeWidget(newKnowledg))
          .toList();
    });
  }

  Future<void> downloadAndOpenPDF(String url, String fileName) async {
    try {
      final shortFileName = fileName.hashCode.toString();
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
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget knowledgeWidget(NewKnowledg newknowledge) {
    return FutureBuilder<bool>(
      future: _hasViewed(newknowledge.id), // ตรวจสอบว่าดูแล้วหรือยัง
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(); // รอข้อมูลจาก SharedPreferences
        }

        bool hasViewed = snapshot.data ?? false;

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: isLoading
                      ? null
                      : () async {
                          setState(() {
                            isLoading = true;
                          });

                          await downloadAndOpenPDF(
                              newknowledge.pdfUrl, newknowledge.name);

                          // เมื่อกดที่รูปภาพ บันทึกว่าได้ดูแล้ว
                          await _markAsViewed(newknowledge.id);

                          // รีเซ็ตสถานะการโหลด
                          setState(() {
                            isLoading = false;
                            hasViewed = true;
                          });
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(newknowledge.coverUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Stack(
                      children: [
                        // แสดงคำว่า "NEW" ที่มุมขวาบนหากยังไม่ได้ดู
                        if (!hasViewed)
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text(
                                'NEW',
                                style: GoogleFonts.k2d(
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPang(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          tr('app.Home'),
          style: GoogleFonts.k2d(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                LineIcons.facebookMessenger,
                size: 35,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return const ChatScreen();
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 50.5,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: const ImageSlide(),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 50),
              const Home_Moddel(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      tr('app.knowledge_news'),
                      style: GoogleFonts.k2d(
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        width: 90,
                        height: 40,
                        child: Card(
                          color: Theme.of(context).dividerColor,
                          shadowColor: Theme.of(context).splashColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11.0),
                          ),
                          child: Center(
                            child: Text(
                              'View More',
                              style: GoogleFonts.k2d(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const NewKnowledge();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100,
              ),
              Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height * 0.25,
                child: knowledgewidgests.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).hoverColor,
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) =>
                            knowledgewidgests[index],
                        itemCount: knowledgewidgests.length > 5
                            ? 5
                            : knowledgewidgests.length,
                      ),
              ),
            ],
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).hoverColor,
              ),
            ),
        ],
      ),
    );
  }
}
