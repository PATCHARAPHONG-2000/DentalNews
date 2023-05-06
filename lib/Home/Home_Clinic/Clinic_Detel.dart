import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_news/Contoller/Color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Firebase/Jason_Dental_Clinic.dart';

// ignore: camel_case_types
class Clinic_Detel extends StatefulWidget {
  final Clinic clinic;

  const Clinic_Detel({
    required this.clinic,
  });

  @override
  _Clinic_DetelState createState() => _Clinic_DetelState();
}

// ignore: camel_case_types
class _Clinic_DetelState extends State<Clinic_Detel> {
  late Clinic clini;
  List<Widget> widgests = [];

  @override
  void initState() {
    super.initState();
    clini = widget.clinic;
    // readData();
    //detelDeata();
  }

  launchUrl(index) async {
    if (await canLaunch(clini.url)) {
      await launch(clini.url);
    } else {
      throw "Could not open $clini";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: color.appBar,
      appBar: AppBar(
        title: Text(clini.name == null ? ' ' : clini.name),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(
                Icons.map_outlined,
              ),
              onPressed: () => launchUrl(clini),
            ),
          ),
        ],
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(clini.image1),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    clini.name,
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
                    'ที่อยู่ : ',
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
                clini.address,
                style: GoogleFonts.k2d(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'เวลาทำการ :',
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
              Padding(
                padding: const EdgeInsets.only(right: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      clini.time,
                      style: GoogleFonts.k2d(
                        textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            overflow: TextOverflow.clip),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
