import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_news/Contoller/Color.dart';
import 'package:dental_news/Home/Home_Toothache/Toot_Detel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Firebase/Jason_Toothache.dart';

class Home_Toothache extends StatefulWidget {
  const Home_Toothache({Key? key}) : super(key: key);

  @override
  _Home_ToothacheState createState() => _Home_ToothacheState();
}

class _Home_ToothacheState extends State<Home_Toothache> {
  List<Widget> widgests = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection("Toothache")
          .where("name")
          .orderBy("name")
          .snapshots()
          .listen((event) {
        print("snapshot = ${event.docs}");
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          print("map =$map");
          Toothache toothache = Toothache.fromMap(map);
          print("name = ${toothache.name}");
          setState(() {
            widgests.add(creatWidget(toothache));
          });
        }
      });
    });
  }

  Widget creatWidget(Toothache toothache) => Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
        child: Stack(
          children: [
            Column(
              children: [
                InkWell(
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(
                          toothache.image,
                        ),
                      ),
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(0),
                      ),
                      border: Border.all(
                          width: 3, color: Theme.of(context).hoverColor),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Toothache_Detel(toothache: toothache),
                      ),
                    );
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        toothache.name,
                        style: GoogleFonts.k2d(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            //overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        //textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Generated code for this Column Widget...
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "อาการปวดฟัน",
          style: GoogleFonts.k2d(),
        ),
      ),
      body: widgests.isEmpty == 0
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.extent(
              childAspectRatio: 0.55,
              // crossAxisSpacing: 0.1,
              // mainAxisSpacing: 0.5,
              maxCrossAxisExtent: 250,
              children: widgests,
            ),
    );
  }
}
