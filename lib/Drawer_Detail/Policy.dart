import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class Policy extends StatefulWidget {
  const Policy({Key? key}) : super(key: key);

  @override
  _PolicyState createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  @override
  Widget build(BuildContext context) {
    // คำนวณขนาดตัวอักษรและระยะห่างตามขนาดของหน้าจอ
    double baseFontSize = MediaQuery.of(context).size.width * 0.05;
    double basePadding = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).dividerColor,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          tr('PDC.Policy_Dental_Council'),
          style: GoogleFonts.k2d(
            textStyle: TextStyle(
              fontSize: baseFontSize + 6,
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
        padding: EdgeInsets.symmetric(horizontal: basePadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: basePadding),
              Container(
                padding: const EdgeInsets.all(16.0),
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // จัดให้อยู่ทางซ้าย
                  children: [
                    // Title
                    Text(
                      tr('PDC.Policy_Dental_Council'),
                      style: TextStyle(
                        fontSize: baseFontSize + 5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: basePadding),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    SizedBox(height: basePadding),
                    // Section PDC1

                    Text(
                      tr('PDC.PDC1'),
                      textAlign: TextAlign.start,
                      style: GoogleFonts.k2d(
                        textStyle: TextStyle(
                          fontSize: baseFontSize + 3,
                        ),
                      ),
                    ),
                    SizedBox(height: basePadding),
                    Center(
                      child: Column(
                        children: [
                          Image.asset(
                            "image/image88.jpg",
                            height: 200, // ปรับความสูงของรูปภาพ
                          ),
                          SizedBox(height: basePadding),
                          Text(
                            tr('PDC.PDC2'),
                            style: GoogleFonts.k2d(
                              textStyle: TextStyle(
                                fontSize: baseFontSize + 2,
                              ),
                            ),
                          ),
                          Text(
                            tr('PDC.PDC3'),
                            style: GoogleFonts.k2d(
                              textStyle: TextStyle(
                                fontSize: baseFontSize + 2,
                              ),
                            ),
                          ),
                          Text(
                            tr('PDC.PDC4'),
                            style: GoogleFonts.k2d(
                              textStyle: TextStyle(
                                fontSize: baseFontSize + 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: basePadding),
              Container(
                padding: const EdgeInsets.all(16.0),
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
                    Text(
                      tr('PDC.PDC5'),
                      textAlign: TextAlign.start,
                      style: GoogleFonts.k2d(
                        textStyle: TextStyle(
                          fontSize: baseFontSize + 3,
                        ),
                      ),
                    ),
                    // Loop สำหรับแสดงข้อมูลจาก PDC6 ถึง PDC12
                    for (var i = 6; i <= 12; i++) ...[
                      SizedBox(height: basePadding / 3),
                      Text(
                        tr('PDC.PDC$i'),
                        style: GoogleFonts.k2d(
                          textStyle: TextStyle(
                            fontSize: baseFontSize,
                            height: 1.5, // ระยะห่างระหว่างบรรทัด
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: basePadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}
