import 'package:dental_news/Contoller/Color.dart';
import 'package:dental_news/Drawer_Detail/Knowledge/Knowledge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Drawer_Detail/History.dart';
import '../Drawer_Detail/Policy.dart';
import '../Drawer_Detail/knowledge_link.dart';
import '../Drawer_Detail/Press_release/press release.dart';

class Drawer_Lift extends StatelessWidget {
  const Drawer_Lift({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            child: const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("image/D2.png"),
                ),
              ),
              child: null,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            child: Card(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              child: Center(
                child: Text(
                  "องค์กรทันตแพทยสภา",
                  style: GoogleFonts.k2d(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: color.white),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const History();
                  },
                ),
              );
            },
            leading: Icon(
              Icons.history_edu,
              size: 35,
              color: Theme.of(context).hoverColor,
            ),
            title: Text(
              "ประวัติความเป็นมา",
              style: GoogleFonts.k2d(
                textStyle: const TextStyle(fontSize: 15),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const Policy();
                  },
                ),
              );
            },
            leading: Icon(
              Icons.history_edu,
              size: 35,
              color: Theme.of(context).hoverColor,
            ),
            title: Text(
              "นโยบายทันตแพทยสภา",
              style: GoogleFonts.k2d(
                textStyle: const TextStyle(fontSize: 15),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            height: 5,
            color: Color(0xFF666666),
          ),

          SizedBox(
            height: 50,
            child: Card(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              child: Center(
                child: Text(
                  "ประชาสัมพันธ์",
                  style: GoogleFonts.k2d(
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: color.white),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const Press_release();
                  },
                ),
              );
            },
            leading: Icon(
              Icons.history_edu,
              size: 35,
              color: Theme.of(context).hoverColor,
            ),
            title: Text(
              "ข่าวประชาสัมพันธ์",
              style: GoogleFonts.k2d(
                textStyle: const TextStyle(fontSize: 15),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const NewKnowledge();
                  },
                ),
              );
            },
            leading: Icon(
              Icons.history_edu,
              size: 35,
              color: Theme.of(context).hoverColor,
            ),
            title: Text(
              "ความรู้ใหม่",
              style: GoogleFonts.k2d(
                textStyle: const TextStyle(fontSize: 15),
              ),
            ),
          ),

          ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Knowledge_link();
                  },
                ),
              );
            },
            leading: Icon(
              Icons.history_edu,
              size: 35,
              color: Theme.of(context).hoverColor,
            ),
            title: Text(
              "ลิ้งค์ความรู้",
              style: GoogleFonts.k2d(
                textStyle: const TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
