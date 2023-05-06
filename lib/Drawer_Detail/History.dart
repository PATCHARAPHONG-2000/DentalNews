//ประวัติความเป็นมา
import 'package:dental_news/Contoller/Color.dart';
import 'package:dental_news/Data/List_Title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'ประวัติความเป็นมา',
          style: GoogleFonts.k2d(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: historye.length,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        historye[index].name,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.k2d(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Divider(
                    thickness: 1.5,
                    color: color.grey,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Text(
                    historye[index].lebbel,
                    style: GoogleFonts.k2d(
                        textStyle: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
