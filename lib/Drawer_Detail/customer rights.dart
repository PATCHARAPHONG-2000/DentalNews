import 'package:dental_news/Contoller/Color.dart';
import 'package:dental_news/Data/List_Title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Customer_Rights extends StatefulWidget {
  const Customer_Rights({Key? key}) : super(key: key);

  @override
  _Customer_RightsState createState() => _Customer_RightsState();
}

class _Customer_RightsState extends State<Customer_Rights> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("สิทธิผู้ป่วยทางทันตกรรม"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: receipte.length,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        receipte[index].name,
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
                    receipte[index].lebbel,
                    style: GoogleFonts.k2d(
                        textStyle: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w300)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
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
