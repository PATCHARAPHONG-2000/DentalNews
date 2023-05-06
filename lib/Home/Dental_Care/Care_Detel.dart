// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dental_news/Firebase/Jason_Data_Care.dart';

class Care_Detel extends StatefulWidget {
  Care_Data care;

  Care_Detel({super.key, required this.care});

  @override
  _Care_DetelState createState() => _Care_DetelState();
}

class _Care_DetelState extends State<Care_Detel> {
  late Care_Data _care_data;
  List<Widget> widgests = [];

  @override
  void initState() {
    super.initState();
    _care_data = widget.care;
    // readData();
    //detelDeata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: color.appBar,
      appBar: AppBar(
        title: Text(_care_data.name == null ? ' ' : _care_data.name),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(_care_data.image1),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    _care_data.name,
                    style: GoogleFonts.k2d(
                      textStyle: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        //color: Theme.of(context).cardColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'รายละเอียด : ',
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
                height: 20,
              ),
              Text(
                _care_data.data,
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
    );
  }
}
