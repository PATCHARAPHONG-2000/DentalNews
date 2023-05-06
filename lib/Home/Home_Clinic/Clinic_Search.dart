import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Clinic_Search extends StatefulWidget {
  const Clinic_Search({super.key});

  @override
  State<Clinic_Search> createState() => _Clinic_SearchState();
}

class _Clinic_SearchState extends State<Clinic_Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("ค้นหาคลินิก"),
      ),
    );
  }
}
