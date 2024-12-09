import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Firebase/FireBase.dart';
import '../../Firebase/Press_release.dart';

class Press_release extends StatefulWidget {
  const Press_release({super.key});

  @override
  State<Press_release> createState() => _Press_releaseState();
}

class _Press_releaseState extends State<Press_release> {
  List<Widget> widgests = [];
  Map<String, bool> viewedItems = {}; // Track viewed items

  @override
  void initState() {
    super.initState();
    loadViewedItems(); // Load viewed state from SharedPreferences
    fetchData(); // Fetch data from Firebase
  }

  // Load viewed items from SharedPreferences
  Future<void> loadViewedItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        viewedItems = prefs.getKeys().fold<Map<String, bool>>({}, (map, key) {
          final value = prefs.get(key);
          if (value is bool) {
            map[key] = value;
          }
          return map;
        });
      });
    } catch (e) {
      print("Error loading viewed items: $e");
    }
  }

  // Mark item as viewed and save in SharedPreferences
  Future<void> markAsViewed(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(id, true);
    setState(() {
      viewedItems[id] = true;
    });
  }

  Future<void> fetchData() async {
    List<Pressrelease> pressreleaseDataList =
        await FireBaseData.pressreleaseData();

    // จัดเรียงให้รายการใหม่แสดงก่อน โดยเช็คว่ามีการดูแล้วหรือไม่
    pressreleaseDataList.sort((a, b) {
      bool aIsNew = viewedItems[a.id] != true;
      bool bIsNew = viewedItems[b.id] != true;

      // รายการที่ยังไม่ได้ดู (id ใหม่) จะถูกจัดให้อยู่ข้างบน
      if (aIsNew && !bIsNew) return -1; // a ใหม่กว่า b
      if (!aIsNew && bIsNew) return 1; // b ใหม่กว่า a
      return 0; // ทั้งคู่เหมือนกัน ให้แสดงตามลำดับเดิม
    });

    // อัปเดตข้อมูลที่จะแสดง
    setState(() {
      widgests = pressreleaseDataList
          .map((careData) => creatWidget(careData))
          .toList();
    });
  }

  Future<void> downloadAndOpenPDF(String url, String fileName) async {
    try {
      final shortFileName =
          fileName.hashCode.toString(); // Use hashCode as file name
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
        print("Unable to open file: ${result.message}");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Widget creatWidget(Pressrelease fireBasePress) {
    bool isNew = viewedItems[fireBasePress.id] != true; // Check if item is new

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                // Mark as viewed when tapped
                markAsViewed(fireBasePress.id);
                downloadAndOpenPDF(
                  fireBasePress.pdfUrl,
                  fireBasePress.title,
                );
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover, // Make image cover the area
                            image: NetworkImage(fireBasePress.coverImageUrl),
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Theme.of(context).focusColor,
                            width: 0.2,
                          ),
                        ),
                      ),
                      if (isNew) // Show "NEW" if not viewed
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.width * 0.02,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.005,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.02,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'NEW',
                              style: GoogleFonts.k2d(
                                textStyle: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      fireBasePress.title,
                      style: GoogleFonts.k2d(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width * 0.04,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'ผู้เขียน: ${fireBasePress.author}',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.k2d(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                          size: MediaQuery.of(context).size.width * 0.04,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'วันที่: ${fireBasePress.date}',
                            style: GoogleFonts.k2d(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
          tr('app.Press_release'),
          style: GoogleFonts.k2d(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.width * 0.05,
            fontWeight: FontWeight.bold,
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
        child: widgests.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).hoverColor,
                ),
              )
            : ListView(
                padding: const EdgeInsets.all(8.0),
                children: widgests,
              ),
      ),
    );
  }
}
