import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Drawer_Detail/History.dart';
import '../Drawer_Detail/Policy.dart';
import '../Widget/Knowledge/Knowledge.dart';
import '../Widget/Press_release/press release.dart';
import '../Widget/knowledge_link.dart';

class DrawerPang extends StatefulWidget {
  const DrawerPang({super.key});

  @override
  State<DrawerPang> createState() => _DrawerPangState();
}

class _DrawerPangState extends State<DrawerPang> {
  @override
  Widget build(BuildContext context) {
    // MediaQuery to handle responsive padding, font size, and element size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      backgroundColor: Theme.of(context).cardColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Responsive DrawerHeader with adjustable height
            SizedBox(
              height: screenHeight * 0.2, // Set height based on screen height
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage("image/LGH.png"),
                  ),
                ),
                child: null,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02), // Responsive padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Dental Council Header
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.03,
                            bottom: screenHeight * 0.01),
                        child: Text(
                          tr('app.Dental_Council'),
                          style: GoogleFonts.k2d(
                            textStyle: TextStyle(
                              fontSize:
                                  screenWidth * 0.05, // Responsive font size
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: screenHeight * 0.005,
                    color: Theme.of(context).splashColor,
                  ),
                  // List Items (History, Policy, etc.)
                  buildDrawerItem(
                    context,
                    screenWidth,
                    screenHeight,
                    icon: 'image/streamline.png',
                    text: tr('His.HisH'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const History();
                        }),
                      );
                    },
                  ),
                  buildDrawerItem(
                    context,
                    screenWidth,
                    screenHeight,
                    icon: 'image/pen.png',
                    text: tr('PDC.Policy_Dental_Council'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const Policy();
                        }),
                      );
                    },
                  ),
                  // Public Relations Header
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.015),
                    child: Row(
                      children: [
                        Text(
                          tr('app.Public_Relations'),
                          style: GoogleFonts.k2d(
                            textStyle: TextStyle(
                              fontSize:
                                  screenWidth * 0.05, // Responsive font size
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: screenHeight * 0.005,
                    color: Theme.of(context).splashColor,
                  ),
                  // List Items (Press Release, Knowledge, etc.)
                  buildDrawerItem(
                    context,
                    screenWidth,
                    screenHeight,
                    icon: 'image/mic.png',
                    text: tr('app.Press_release'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const Press_release();
                        }),
                      );
                    },
                  ),
                  buildDrawerItem(
                    context,
                    screenWidth,
                    screenHeight,
                    icon: 'image/book.png',
                    text: tr('app.knowledge'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const NewKnowledge();
                        }),
                      );
                    },
                  ),
                  buildDrawerItem(
                    context,
                    screenWidth,
                    screenHeight,
                    icon: 'image/link.png',
                    text: tr('app.knowledge_link'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return const KnowledgeLink();
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build Drawer items with responsive layout
  ListTile buildDrawerItem(
      BuildContext context, double screenWidth, double screenHeight,
      {required String icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      onTap: onTap,
      title: Text(
        text,
        style: GoogleFonts.k2d(
          textStyle: TextStyle(fontSize: screenWidth * 0.04),
        ),
      ),
      leading: Image.asset(
        icon,
        color: Theme.of(context).splashColor,
        width: screenWidth * 0.06, // Adjust icon size responsively
      ),
    );
  }
}
