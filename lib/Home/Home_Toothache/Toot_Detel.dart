import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../../Firebase/Toothache.dart';

class Toothache_Detel extends StatefulWidget {
  final Toothache toothache;
  const Toothache_Detel({super.key, required this.toothache});

  @override
  State<Toothache_Detel> createState() => _Toothache_DetelState();
}

class _Toothache_DetelState extends State<Toothache_Detel> {
  late Toothache toothache;

  @override
  void initState() {
    super.initState();
    toothache = widget.toothache;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          toothache.name,
          style: GoogleFonts.k2d(
            textStyle: TextStyle(
              fontSize: screenWidth * 0.05, // ปรับขนาดฟอนต์ตามหน้าจอ
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).dividerColor,
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(LineIcons.chevronCircleLeft),
          onPressed: () {
            Navigator.pop(context, true); // ส่งค่ากลับว่าได้ทำการดูข้อมูลแล้ว
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.05), // ปรับ padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  child: Image.network(
                    toothache.imageUrl,
                    width: screenWidth, // กำหนดขนาดรูปภาพเต็มหน้าจอ
                    height: screenHeight * 0.3, // ปรับความสูงของรูปภาพ
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02, // ปรับระยะห่าง
                ),
                Row(
                  children: [
                    Text(
                      toothache.name,
                      style: GoogleFonts.k2d(
                        textStyle: TextStyle(
                          fontSize: screenWidth * 0.06, // ปรับขนาดฟอนต์
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01, // ปรับระยะห่าง
                ),
                RichText(
                  text: TextSpan(
                    text: 'ผู้เขียน: ', // ข้อความส่วนที่ต้องการให้เป็นตัวหนา
                    style: GoogleFonts.k2d(
                      textStyle: TextStyle(
                        fontSize: screenWidth * 0.045, // ปรับขนาดฟอนต์
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).splashColor,
                      ),
                    ),
                    children: [
                      TextSpan(
                        text: toothache.author, // ข้อความส่วนที่เหลือ
                        style: GoogleFonts.k2d(
                          textStyle: TextStyle(
                            fontSize: screenWidth * 0.045, // ปรับขนาดฟอนต์
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).splashColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01, // ปรับระยะห่าง
                ),
                RichText(
                  text: TextSpan(
                    text: 'วันที่: ',
                    style: GoogleFonts.k2d(
                      textStyle: TextStyle(
                        fontSize: screenWidth * 0.045, // ปรับขนาดฟอนต์
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).splashColor,
                      ),
                    ),
                    children: [
                      TextSpan(
                        text: toothache.time,
                        style: GoogleFonts.k2d(
                          textStyle: TextStyle(
                            fontSize: screenWidth * 0.045, // ปรับขนาดฟอนต์
                            fontWeight: FontWeight.w300,
                            color: Theme.of(context).splashColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.015, // ปรับระยะห่าง
                ),
                Row(
                  children: [
                    Text(
                      tr('app.Details'),
                      style: GoogleFonts.k2d(
                        textStyle: TextStyle(
                          fontSize: screenWidth * 0.045, // ปรับขนาดฟอนต์
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01, // ปรับระยะห่าง
                ),
                Text(
                  toothache.content,
                  style: GoogleFonts.k2d(
                    textStyle: TextStyle(
                      fontSize: screenWidth * 0.04, // ปรับขนาดฟอนต์
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
