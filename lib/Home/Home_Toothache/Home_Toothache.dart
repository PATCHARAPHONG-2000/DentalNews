import 'package:dentalnews/Model/drawer_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Firebase/FireBase.dart';
import '../../Firebase/Toothache.dart';
import 'Toot_Detel.dart';

class Home_Toothache extends StatefulWidget {
  const Home_Toothache({Key? key}) : super(key: key);

  @override
  _Home_ToothacheState createState() => _Home_ToothacheState();
}

class _Home_ToothacheState extends State<Home_Toothache> {
  List<Widget> widgests = [];
  Map<String, bool> viewedItems = {}; // Keep track of viewed items
  bool isLoading = true; // เพิ่มสถานะการโหลดข้อมูล

  @override
  void initState() {
    super.initState();
    loadViewedItems(); // Load viewed items from shared preferences
    fetchData(); // Fetch data from Firebase
  }

  // Load viewed items from shared preferences
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

  // Save viewed item to shared preferences
  Future<void> markAsViewed(String id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(id, true); // Store the viewed status
      setState(() {
        viewedItems[id] = true;
      });
    } catch (e) {
      print("Error saving viewed item: $e");
    }
  }

  Future<void> fetchData() async {
    try {
      List<Toothache> toothacheDataList = await FireBaseData.toothacheData();

      // จัดเรียงให้รายการใหม่แสดงก่อน โดยเช็คว่ามีการดูแล้วหรือไม่
      toothacheDataList.sort((a, b) {
        bool aIsNew = viewedItems[a.id] != true;
        bool bIsNew = viewedItems[b.id] != true;

        if (aIsNew && !bIsNew) return -1; // a ใหม่กว่า b
        if (!aIsNew && bIsNew) return 1; // b ใหม่กว่า a
        return 0; // ทั้งคู่เหมือนกัน ให้แสดงตามลำดับเดิม
      });

      // อัปเดตข้อมูลที่จะแสดง
      setState(() {
        widgests = toothacheDataList
            .map((toothache) => creatWidget(toothache))
            .toList();
      });
    } catch (e) {
      // จัดการกรณีเกิดข้อผิดพลาดในการดึงข้อมูลจาก Firebase
      print("Error fetching data: $e");
    } finally {
      setState(() {
        isLoading = false; // อัปเดตสถานะการโหลดเสร็จสิ้น
      });
    }
  }

  Widget creatWidget(Toothache toothache) {
    bool isNew = viewedItems[toothache.id] != true; // Check if item is new

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width *
            0.03, // Adjust according to screen size
      ),
      child: Column(
        children: [
          InkWell(
            highlightColor: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width *
                  0.7, // Adjust to screen size
              height: MediaQuery.of(context).size.height *
                  0.30, // Adjust to screen size
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(toothache.imageUrl),
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).focusColor, // Border color
                  width: 0.5, // Border width
                ),
              ),
              child: Stack(
                children: [
                  if (isNew) // Show "NEW" if not viewed
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.04,
                      right: MediaQuery.of(context).size.width * 0.02,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                MediaQuery.of(context).size.height * 0.005,
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02),
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
                  SizedBox(height: MediaQuery.of(context).size.height / 1.0),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.001,
                    left: 0,
                    right: 0,
                    child: Text(
                      toothache.name,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.k2d(
                        color: Theme.of(context).focusColor,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.w900,
                        height:
                            1.2, // Adjust the height for consistent line spacing
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () async {
              // Mark item as viewed and save state
              await markAsViewed(toothache.id);

              // Navigate to the detail page
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Toothache_Detel(toothache: toothache),
                ),
              );

              // Force update the UI to refresh the state when returning back
              setState(() {
                viewedItems[toothache.id] = true;
              });
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.02, // เพิ่มระยะห่างระหว่างรูปและชื่อ
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPang(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          tr('app.toothache'),
          style: GoogleFonts.k2d(
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).hoverColor,
              ),
            )
          : GridView.extent(
              childAspectRatio: 0.70,
              crossAxisSpacing: MediaQuery.of(context).size.width * 0.006,
              mainAxisSpacing: MediaQuery.of(context).size.height * 0.05,
              maxCrossAxisExtent: 350,
              children: widgests,
            ),
    );
  }
}
