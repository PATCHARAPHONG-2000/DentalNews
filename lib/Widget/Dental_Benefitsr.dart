// ignore: file_names
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../Data/List_Title.dart';
import '../utils/utils.dart';

class Dental_Benefitsr extends StatefulWidget {
  const Dental_Benefitsr({super.key});

  @override
  _Dental_BenefitsrState createState() => _Dental_BenefitsrState();
}

class _Dental_BenefitsrState extends State<Dental_Benefitsr> {
  @override
  Widget build(BuildContext context) {
    // คำนวณขนาดหน้าจอเพื่อทำให้ UI responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // ขนาดฟอนต์และระยะห่างพื้นฐาน
    double baseFontSize = screenWidth * 0.045;
    double basePadding = screenHeight * 0.02;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          tr('DB.Dental_Benefits'),
          style: GoogleFonts.k2d(
            textStyle: TextStyle(
              fontSize: baseFontSize + 5, // ปรับขนาดฟอนต์ตามหน้าจอ
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Icon(LineIcons.chevronCircleLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(basePadding), // ปรับ padding ให้ responsive
        child: ListView.builder(
          itemCount: volunteere.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: basePadding / 3),
              child: Container(
                padding: EdgeInsets.all(basePadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ชื่อหัวข้อแต่ละรายการ
                    Text(
                      volunteere[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.k2d(
                        textStyle: TextStyle(
                          fontSize: baseFontSize + 2, // ขนาดฟอนต์
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: basePadding / 2),

                    // เส้นแบ่ง
                    Divider(
                      thickness: 1.5,
                      color: color.grey,
                    ),
                    SizedBox(height: basePadding / 2),

                    // เนื้อหาแต่ละรายการ
                    Text(
                      volunteere[index].lebbel,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.k2d(
                        textStyle: TextStyle(
                          fontSize: baseFontSize, // ขนาดฟอนต์
                          fontWeight: FontWeight.w300,
                          height: 1.5, // เพิ่มระยะห่างระหว่างบรรทัด
                        ),
                      ),
                    ),
                    SizedBox(height: basePadding), // เพิ่มระยะห่างด้านล่าง
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
