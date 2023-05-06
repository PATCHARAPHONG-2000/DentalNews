import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_news/Contoller/Color.dart';
import 'package:dental_news/Drawer_Detail/Knowledge/ViwePDF_Knowledge.dart';
import 'package:dental_news/Firebase/Jason_Knowledge.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewKnowledge extends StatefulWidget {
  const NewKnowledge({super.key});

  @override
  State<NewKnowledge> createState() => _NewKnowledgeState();
}

class _NewKnowledgeState extends State<NewKnowledge> {
  List<Widget> knowledgewidgests = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection("Knowledge_news")
          .where("url")
          .orderBy("name")
          .snapshots()
          .listen((event) {
        print("snapshot = ${event.docs}");

        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          print("map =$map");
          New_Knowledge newknowledge = New_Knowledge.fromMap(map);
          print("name = ${newknowledge.name}");
          setState(() {
            knowledgewidgests.add(knowledgeWidget(newknowledge));
          });
        }
      });
    });
  }

  Widget knowledgeWidget(New_Knowledge newknowledge) => Center(
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
                            return ViwePDF_Knowledge(
                              new_knowledge: newknowledge,
                              pdfDocument: PDFDocument(),
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
                        newknowledge.image,
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
                        newknowledge.name,
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
        title: Text(
          'ความรู้ใหม่',
          style: GoogleFonts.k2d(),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: knowledgewidgests.isEmpty
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
              children: knowledgewidgests,
            ),
    );
  }
}
