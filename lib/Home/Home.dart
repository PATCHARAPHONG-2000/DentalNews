import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dental_news/Contoller/Color.dart';
import 'package:dental_news/Home/Dental_Care/Home_Care.dart';
import 'package:dental_news/Home/Home_Toothache/Home_Toothache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'Call/caal.dart';
import 'Home_Clinic/Home_Clinic.dart';
import 'Home_Sceen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Home_Sceen(),
    const Call(),
    const Home_Toothache(),
    const Home_Care(),
    const Home_Clinic(),
    const Home_Sceen(),
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavyBar(
        itemCornerRadius: 50,
        iconSize: 30,
        showElevation: true,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Theme.of(context).primaryColor,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Center(child: Icon(Icons.home)),
            title: const Center(child: Text('หน้าหลัก')),
            activeColor: Theme.of(context).cardColor,
          ),
          BottomNavyBarItem(
            icon: const Center(child: Icon(Icons.contact_phone)),
            title: const Center(child: Text('ติดต่อ')),
            activeColor: Theme.of(context).cardColor,
          ),
          BottomNavyBarItem(
            icon: const Center(child: Icon(Icons.vaccines)),
            title: const Center(child: Text('อากการปวด')),
            activeColor: Theme.of(context).cardColor,
          ),
          BottomNavyBarItem(
            icon: const Center(child: Icon(Icons.medication_liquid)),
            title: const Center(child: Text('วิธีดูแลฟัน')),
            activeColor: Theme.of(context).cardColor,
          ),
          BottomNavyBarItem(
            icon: const Center(child: Icon(Icons.add_location)),
            title: const Center(child: Text('คลินิก')),
            activeColor: Theme.of(context).cardColor,
          ),
        ],
      ),
    );
  }
}
