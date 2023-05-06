import 'package:dental_news/Contoller/Color.dart';
import 'package:dental_news/Data/List_Title.dart';
import 'package:dental_news/Drawer_Detail/customer%20rights.dart';
import 'package:dental_news/Drawer_Detail/payments.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Drawer_Detail/Dental_Benefitsr.dart';

class Home_Moddel extends StatelessWidget {
  const Home_Moddel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "หมวดหมู่",
                  style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Theme.of(context).backgroundColor.withAlpha(9),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 24.0),
              height: MediaQuery.of(context).size.height / 8.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return Payments();
                          },
                        ),
                      );
                    },
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: Card(
                        shadowColor: Theme.of(context).primaryColor,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "ค่าบริการทันตกรรม",
                                    style: GoogleFonts.k2d(
                                      textStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                        color: Theme.of(context).cardColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const Customer_Rights();
                          },
                        ),
                      );
                    },
                    child: Card(
                      shadowColor: Theme.of(context).primaryColor,
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "สิทธิผู้ป่วยทางทันตกรรม",
                                  style: GoogleFonts.k2d(
                                    textStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                      color: Theme.of(context).cardColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const Dental_Benefitsr();
                          },
                        ),
                      );
                    },
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: Card(
                        shadowColor: Theme.of(context).primaryColor,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 0.0, 10.0, 0.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "สิทธิประโยชน์ทางทันตกรรม",
                                    style: GoogleFonts.k2d(
                                      textStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                        color: Theme.of(context).cardColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
    );
  }
}
