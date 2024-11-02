import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Mapviwe_Call extends StatefulWidget {
  const Mapviwe_Call({super.key});

  @override
  State<Mapviwe_Call> createState() => _Mapviwe_CallState();
}

class _Mapviwe_CallState extends State<Mapviwe_Call> {
  final String lat = "37.3230";
  final String lng = "-122.0312";
  _luncherMAP() async {
    const String mapUrl = "geo:0,0?q=Pjm4QSbnqFxrqP5K6";
    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw "Couldn't launch Map";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // ...
          ListTile(
        title: Text("Launch Maps"),
        onTap: () async {
          final String googleMapsUrl = "geo:0,0?q=Pjm4QSbnqFxrqP5K6";
          final String appleMapsUrl =
              "https://maps.apple.com/?q=Pjm4QSbnqFxrqP5K6";

          if (await canLaunch(googleMapsUrl)) {
            await launch(googleMapsUrl);
          } else if (await canLaunch(appleMapsUrl)) {
            await launch(appleMapsUrl, forceSafariVC: false);
          } else {
            throw "Couldn't launch Maps";
          }
        },
      ),
    );
  }
}
