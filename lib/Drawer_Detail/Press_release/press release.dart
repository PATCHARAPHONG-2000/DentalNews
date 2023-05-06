import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_news/Contoller/Color.dart';
import 'package:dental_news/Drawer_Detail/Press_release/ViwePDF_Press_release.dart';
import 'package:dental_news/Firebase/Jason_Press_release.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class Press_release extends StatefulWidget {
  const Press_release({super.key});

  @override
  State<Press_release> createState() => _Press_releaseState();
}

class _Press_releaseState extends State<Press_release> {
  List<Widget> fireBase_Press = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection("Press_release")
          .where("url")
          .orderBy("name")
          .snapshots()
          .listen((event) {
        print("snapshot = ${event.docs}");

        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          print("map =$map");
          FireBase_Press_release fireBasePress =
              FireBase_Press_release.fromMap(map);
          print("name = ${fireBasePress.name}");
          setState(() {
            fireBase_Press.add(FireBase_Press(fireBasePress));
          });
        }
      });
    });
  }

  Widget FireBase_Press(FireBase_Press_release fireBasePress) => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ViwePDF_PressRelease(
                              fireBasePress: fireBasePress,
                            );
                          },
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusDirectional.circular(20)),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        fireBasePress.image,
                        width: double.maxFinite,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        fireBasePress.name,
                        style: GoogleFonts.k2d(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("ข่าวประชาสัมพันธ์"),
      ),
      body: fireBase_Press.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: color.blue,
              ),
            )
          : GridView.extent(
              childAspectRatio: 0.57,
              crossAxisSpacing: 0.5,
              mainAxisSpacing: 0.1,
              maxCrossAxisExtent: 350,
              children: fireBase_Press,
            ),
    );
  }
}
