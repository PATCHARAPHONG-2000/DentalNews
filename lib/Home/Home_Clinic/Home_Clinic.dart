import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_news/Contoller/Color.dart';
import 'package:dental_news/Firebase/Jason_Dental_Clinic.dart';
import 'package:dental_news/Home/Home_Clinic/Clinic_Search.dart';
import 'package:dental_news/ThemeMode/AppTheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Clinic_Detel.dart';

class Home_Clinic extends StatefulWidget {
  const Home_Clinic({Key? key}) : super(key: key);

  @override
  _Home_ClinicState createState() => _Home_ClinicState();
}

class _Home_ClinicState extends State<Home_Clinic> {
  List<Widget> widgests = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection("Dental_clinic")
          .where("name")
          .orderBy("name")
          .snapshots()
          .listen((event) {
        print("snapshot = ${event.docs}");
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          print("map =$map");
          Clinic clinic = Clinic.fromMap(map);
          print("name = ${clinic.name}");
          setState(() {
            widgests.add(creatWidget(clinic));
          });
        }
      });
    });
  }

  Widget creatWidget(Clinic clinic) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Clinic_Detel(
                        clinic: clinic,
                      );
                    },
                  ),
                );
              },
              child: Container(
                // width: 200,
                height: 100,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    tileMode: TileMode.clamp,
                    colors: [
                      Color.fromARGB(255, 204, 171, 219),
                      Color(0xFF8009B8),
                    ],
                    stops: [0, 1],
                    begin: AlignmentDirectional(0.34, -1),
                    end: AlignmentDirectional(-0.34, 1),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            clinic.name,
                            style: GoogleFonts.k2d(
                              textStyle: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                clinic.time,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.k2d(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Theme.of(context).cardColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                clinic.time_out,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.k2d(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Theme.of(context).cardColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "คลินิกทันตกรรม",
          style: GoogleFonts.k2d(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const Clinic_Search();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      // ignore: unrelated_type_equality_checks
      body: widgests.isEmpty == 0
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  child: Column(children: widgests),
                );
              },
            ),
    );
  }
}
