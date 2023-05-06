import 'package:dental_news/Contoller/Color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Call extends StatefulWidget {
  const Call({Key? key}) : super(key: key);

  @override
  _personState createState() => _personState();
}

final Uri _url = Uri.https('https://goo.gl/maps/9t8CYvrkfnLx99rLA');

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

class _personState extends State<Call> {
  Widget? get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.map_outlined,
              ),
              onPressed: () async {
                const String mapUrl = "https://goo.gl/maps/Pjm4QSbnqFxrqP5K6";
                if (await canLaunch(mapUrl)) {
                  await launch(mapUrl);
                } else {
                  throw "Couldn't launch Map";
                }
              },
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.messenger))
        ],
        title: Text(
          "ติดต่อ",
          style: GoogleFonts.k2d(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'CDEC',
                style: TextStyle(fontSize: 60),
              ),
              Text(
                'ศูนย์การศึกษาต่อ',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                'เนื่องของทันตแพทย์ ทันตแพทยสภา',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                'ศ.ป.ท',
                style: TextStyle(fontSize: 60),
              ),
              Text(
                'ศูนย์ประเมินและรับรองความรู้',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                'ความสามารถในการประกอบ',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                'วิชาชีพทันตกรรม',
                style: TextStyle(fontSize: 17),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60),
              ),
              Text(
                'ที่อยู่            :   88/19 หมู่ที่ 4 ชั้น5 อาคารสภาวิชาชีพ ',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                '                       ซอยสาธารณสุข 8 กระทรวงสาธารณสุข ',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                '                       ถนนติวานนท์ ตำบลตลาดขวัญ ',
                style: TextStyle(fontSize: 17),
              ),
              Text(
                '                       อำเถอเมือง จังหวัดนนทบุรี 11000',
                style: TextStyle(fontSize: 17),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                'Phone        :  02 580 7500 ถึง 3',
                style: TextStyle(fontSize: 17),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text(
                'E-mail        :  dent11@dentalcouncil.or.th',
                style: TextStyle(fontSize: 17),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text(
                '                   :  cdec_center@yahoo.com',
                style: TextStyle(fontSize: 17),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Text(
                '                   :  cdec@dentalcouncil.or.th',
                style: TextStyle(fontSize: 17),
              ),
              Padding(
                padding: EdgeInsets.only(top: 17),
              ),
              Text(
                '                   :  cdathai@gmail.com',
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
