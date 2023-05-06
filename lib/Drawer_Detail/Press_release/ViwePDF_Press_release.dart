import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_news/Firebase/Jason_Knowledge.dart';
import 'package:dental_news/Firebase/Jason_Press_release.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class ViwePDF_PressRelease extends StatefulWidget {
//   // PDFDocument pdfDocument;
//   FireBase_Press_release fireBasePress;
//   ViwePDF_PressRelease({super.key, required this.fireBasePress});

//   @override
//   State<ViwePDF_PressRelease> createState() => _ViwePDF_PressReleaseState();
// }

// class _ViwePDF_PressReleaseState extends State<ViwePDF_PressRelease> {
//   final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

//   List<Widget> fireBasePress = [];

//   @override
//   void initState() {
//     super.initState();
//     readData();
//   }

//   Future<Null> readData() async {
//     await Firebase.initializeApp().then((value) async {
//       await FirebaseFirestore.instance
//           .collection("Press_release")
//           .where("url")
//           .orderBy("name")
//           .snapshots()
//           .listen((event) {
//         print("snapshot = ${event.docs}");

//         for (var snapshot in event.docs) {
//           Map<String, dynamic> map = snapshot.data();
//           print("map =$map");
//           FireBase_Press_release fireBasePress =
//               FireBase_Press_release.fromMap(map);
//           print("name = ${fireBasePress.name}");
//           // setState(() {
//           //   fireBase_Press.add(FireBase_Press(fireBasePress));
//           // });
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(fireBase_Press.name),
//       ),
//       body: fireBasePress.isEmpty
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : SfPdfViewer.network(fireBase_Press.pdf),
//     );
//   }
// }

class ViwePDF_PressRelease extends StatefulWidget {
  final FireBase_Press_release fireBasePress;
  ViwePDF_PressRelease({Key? key, required this.fireBasePress})
      : super(key: key);

  @override
  _ViwePDF_PressReleaseState createState() => _ViwePDF_PressReleaseState();
}

class _ViwePDF_PressReleaseState extends State<ViwePDF_PressRelease> {
  late final SfPdfViewer _pdfViewer;

  @override
  void initState() {
    super.initState();
    _pdfViewer = SfPdfViewer.network(widget.fireBasePress.pdf);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fireBasePress.name),
      ),
      body: SfPdfViewer.network(
          "https://drive.google.com/file/d/1aFE5Kf5Hu0TCx5ngTpa-GDG9UOXQ54De/view?usp=share_link"),
    );
  }
}
