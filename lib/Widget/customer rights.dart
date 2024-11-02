import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../Data/List_Title.dart'; // ไฟล์ที่เก็บข้อมูล Receipte
import '../utils/utils.dart'; // ฟังก์ชันอื่นๆ ที่เกี่ยวข้อง

class Customer_Rights extends StatefulWidget {
  const Customer_Rights({Key? key}) : super(key: key);

  @override
  _Customer_RightsState createState() => _Customer_RightsState();
}

class _Customer_RightsState extends State<Customer_Rights> {
  @override
  Widget build(BuildContext context) {
    // คำนวณขนาดตัวอักษรและระยะห่างตามขนาดของหน้าจอ
    double baseFontSize =
        MediaQuery.of(context).size.width * 0.045; // ขนาดฟอนต์ฐาน
    double basePadding =
        MediaQuery.of(context).size.height * 0.02; // ระยะห่างฐาน

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          tr('DPR.Dental_patient_rights'),
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
        padding: EdgeInsets.all(basePadding), // ปรับ Padding ตามขนาดหน้าจอ
        child: ListView.builder(
          itemCount: receipte.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  EdgeInsets.only(bottom: basePadding), // ระยะห่างระหว่างรายการ
              child: Container(
                padding: EdgeInsets.all(
                    basePadding), // ระยะห่างภายในกล่องแต่ละรายการ
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
                    // ชื่อรายการ
                    Text(
                      receipte[index].name,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.k2d(
                        textStyle: TextStyle(
                          fontSize: baseFontSize + 3, // ปรับขนาดฟอนต์ตามหน้าจอ
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: basePadding / 2), // ระยะห่างหลังชื่อรายการ

                    // เส้นแบ่ง
                    Divider(
                      thickness: 1.5,
                      color: color.grey,
                    ),
                    SizedBox(height: basePadding / 2), // ระยะห่างหลังเส้นแบ่ง

                    // เนื้อหาของรายการจาก receipte[index].lebbel
                    Text(
                      receipte[index].lebbel,
                      textAlign: TextAlign.start, // จัดให้ข้อความเต็มบรรทัด
                      style: GoogleFonts.k2d(
                        textStyle: TextStyle(
                          fontSize: baseFontSize, // ขนาดฟอนต์ตามหน้าจอ
                          fontWeight: FontWeight.w300,
                          height: 1.5, // เพิ่มระยะห่างระหว่างบรรทัด
                        ),
                      ),
                    ),
                    SizedBox(height: basePadding), // ระยะห่างหลังข้อความ
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
