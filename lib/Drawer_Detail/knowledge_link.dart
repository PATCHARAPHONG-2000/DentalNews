import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_news/Contoller/Color.dart';
import 'package:dental_news/Firebase/Jason_Knowledge_Link.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Data/List_Title.dart';

// ignore: camel_case_types
class Knowledge_link extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _Knowledge_linkState createState() => _Knowledge_linkState();
}

// ignore: camel_case_types
class _Knowledge_linkState extends State<Knowledge_link> {
  List<Widget> linkwidgests = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection("Knowledge_Link")
          .where("url")
          .orderBy("name")
          .snapshots()
          .listen((event) {
        print("snapshot = ${event.docs}");

        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          print("map =$map");
          Know_Link knowLink = Know_Link.fromMap(map);
          print("name = ${knowLink.name}");
          setState(() {
            linkwidgests.add(creatWidget(knowLink));
          });
        }
      });
    });
  }

  Widget creatWidget(Know_Link knowlink) => GestureDetector(
        onTap: () async {
          if (await canLaunch(knowlink.url)) {
            await launch(knowlink.url);
          } else {
            print("chick $knowlink");
            throw "Could not open $knowlink";
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Stack(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(width: 2, color: Theme.of(context).hoverColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15),
                child: Text(
                  knowlink.name,
                  style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                      //color: Theme.of(context).cardColor,
                    ),
                  ),
                ),
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
        title: Text(
          "ลิ้งความรู้",
          style: GoogleFonts.k2d(),
        ),
      ),
      body: linkwidgests.isEmpty == 0
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: linkwidgests,
                );
              },
            ),
    );
  }
}
