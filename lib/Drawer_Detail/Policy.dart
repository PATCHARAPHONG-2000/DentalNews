//นโยบายทันตแพทยสภา
import 'package:dental_news/Contoller/Color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Policy extends StatefulWidget {
  const Policy({Key? key}) : super(key: key);

  @override
  _PolicyState createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'นโยบายทันตแพทยสภา',
          style: GoogleFonts.k2d(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "นโยบายของทันตแพทยสภา",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Divider(
                color: color.grey,
                thickness: 1,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Text(
                "วิสัยทัศน์",
                style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                  fontSize: 25,
                )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                child: Column(
                  children: [
                    Image.asset(
                      "image/image88.jpg",
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Text(
                      "ผดุงความเป็นธรรม มุ่งนำพัฒนา",
                      style: GoogleFonts.k2d(
                        textStyle: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Text(
                      "สร้างมาตรฐานการรักษา",
                      style: GoogleFonts.k2d(
                        textStyle: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    Text(
                      "เพื่อประชาชนไทย",
                      style: GoogleFonts.k2d(
                        textStyle: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Divider(
                color: color.grey,
                thickness: 1,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Text(
                "พันธกิจ",
                style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                  fontSize: 25,
                )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Text(
                "1. ส่งเสริมการศึกษา วิจัย และการประกอบวิชาชีพในทางทันตแพทย์",
                style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                  fontSize: 17,
                )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 150),
              Text(
                "2. ส่งเสริมความสามัคคีและผดุงเกียรติสมาชิก",
                style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                  fontSize: 17,
                )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 150),
              Text(
                "3. ผดุงไว้ซึ่งสิทธิ ความเป็นธรรม และส่งเสริมสวัสดิการให้แก่สมาชิก",
                style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                  fontSize: 17,
                )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 150),
              Text(
                "4. ควบคุมความประพฤติของผู้ประกอบวิชาชีพทันตกรรมให้ถูกต้องตามจรรยาบรรณแห่งวิชาชีพทันตกรรม",
                style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                  fontSize: 17,
                )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 150),
              Text(
                "5. ช่วยเหลือ แนะนำ เผยแพร่ และให้การศึกษาแก่ประชาชนและองค์กรอื่นในเรื่องที่เกี่ยวกับการทันตแพทย์และทันตสาธารณสุข",
                style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                  fontSize: 17,
                )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 150),
              Text(
                "6. ให้คำปรึกษาหรือข้อเสนอแนะต่อรัฐบาลเกี่ยวกับการทันตแพทย์และทันตสาธารณสุข",
                style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                  fontSize: 17,
                )),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 150),
              Text(
                "7. เป็นตัวแทนของผู้ประกอบวิชาชีพทันตกรรมในประเทศไทย",
                style: GoogleFonts.k2d(
                    textStyle: const TextStyle(
                  fontSize: 17,
                )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
