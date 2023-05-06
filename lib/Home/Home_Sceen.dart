import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_news/Contoller/Color.dart';
import 'package:dental_news/Drawer_Detail/Knowledge/Knowledge.dart';
import 'package:dental_news/Model/Image_slide.dart';
import 'package:dental_news/Model/Home_Model.dart';
import 'package:dental_news/Model/drawer_screen.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Drawer_Detail/Knowledge/ViwePDF_Knowledge.dart';
import '../Drawer_Detail/Press_release/ViwePDF_Press_release.dart';
import '../Firebase/Jason_Knowledge.dart';
import '../ThemeMode/ThemeProvider.dart';

class Home_Sceen extends StatefulWidget {
  const Home_Sceen({super.key});

  @override
  State<Home_Sceen> createState() => _Home_SceenState();
}

class _Home_SceenState extends State<Home_Sceen> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      drawer: const Drawer_Lift(),
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            "หน้าหลัก",
            style: GoogleFonts.k2d(),
          ),
          actions: [
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      themeProvider.changeTheme();
                    },
                    icon: Icon(
                      themeProvider.isDarkTheme
                          ? Icons.dark_mode_outlined
                          : Icons.dark_mode_sharp,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.language)),
          ]),
      body: Container(
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 40,
            ),
            const SizedBox(
              height: 250,
              child: Image_slide(),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            Home_Moddel(),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "ความรู้ใหม่",
                    style: GoogleFonts.k2d(
                      textStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: 90,
                      height: 30,
                      child: Card(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Center(
                          child: Text(
                            "View more",
                            style: GoogleFonts.k2d(
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).cardColor,
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
              height: 10,
            ),
            Container(
              width: 200,
              height: 210,
              child: Knowledge(),
            ),
          ],
        ),
      ),
    );
  }
}

class Knowledge extends StatefulWidget {
  const Knowledge({Key? key}) : super(key: key);

  @override
  State<Knowledge> createState() => _KnowledgeState();
}

class _KnowledgeState extends State<Knowledge> {
  List<Widget> knowledgeWidgets = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    await Firebase.initializeApp();
    final snapshot = await FirebaseFirestore.instance
        .collection("Knowledge_news")
        .orderBy("name")
        .get();

    setState(() {
      knowledgeWidgets = snapshot.docs.map((document) {
        final newknowledge = New_Knowledge.fromMap(document.data());
        return knowledgeWidget(newknowledge);
      }).toList();
    });
  }

  Widget knowledgeWidget(New_Knowledge newknowledge) => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: color.grey,
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(newknowledge.image),
                        fit: BoxFit.fill,
                      ),
                    ),
                    width: 130, // กำหนดความกว้างของรูปภาพ
                    height: 190, // กำหนดความสูงของรูปภาพ
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
      backgroundColor: Colors.transparent,
      body: knowledgeWidgets.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: color.blue,
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) =>
                  knowledgeWidgets[index],
              itemCount: knowledgeWidgets.length,
            ),
    );
  }
}
