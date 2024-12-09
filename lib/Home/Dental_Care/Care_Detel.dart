import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../../Firebase/Data_Care.dart';

// ignore: must_be_immutable
class Care_Detel extends StatefulWidget {
  Care_Data care;

  Care_Detel({super.key, required this.care});

  @override
  // ignore: library_private_types_in_public_api
  _Care_DetelState createState() => _Care_DetelState();
}

class _Care_DetelState extends State<Care_Detel> {
  // ignore: non_constant_identifier_names
  Care_Data? care_data;
  List<Widget> widgests = [];

  @override
  void initState() {
    super.initState();
    care_data = widget.care;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: color.appBar,
      appBar: AppBar(
        title: Text(care_data!.name),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Theme.of(context).dividerColor,
        leading: IconButton(
          icon: const Icon(LineIcons.chevronCircleLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(care_data!.imageUrl),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      care_data!.name,
                      style: GoogleFonts.k2d(
                        textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: 'ผู้เขียน: ', // ข้อความส่วนที่ต้องการให้เป็นตัวหนา
                    style: GoogleFonts.k2d(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).splashColor,
                      ),
                    ),
                    children: [
                      TextSpan(
                        text: care_data!.author, // ข้อความส่วนที่เหลือ
                        style: GoogleFonts.k2d(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300, // กำหนดให้เป็นปกติ
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: 'วันที่: ', // ข้อความส่วนที่ต้องการให้เป็นตัวหนา
                    style: GoogleFonts.k2d(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold, // กำหนดให้เป็นตัวหนา
                        color: Theme.of(context).splashColor,
                      ),
                    ),
                    children: [
                      TextSpan(
                        text: care_data!.time, // ข้อความส่วนที่เหลือ
                        style: GoogleFonts.k2d(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w300, // กำหนดให้เป็นปกติ
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text(
                      tr('app.Details'),
                      style: GoogleFonts.k2d(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  care_data!.content,
                  style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
