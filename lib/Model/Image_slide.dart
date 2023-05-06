import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dental_news/Contoller/Color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../Firebase/Jason_Image_Slide.dart';

class Image_slide extends StatefulWidget {
  const Image_slide({super.key});

  @override
  State<Image_slide> createState() => _Image_slideState();
}

class _Image_slideState extends State<Image_slide> {
  List<Widget> widgests = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseFirestore.instance
          .collection("Image_slide")
          .orderBy("id")
          .snapshots()
          .listen((event) {
        print("snapshot = ${event.docs}");
        for (var snapshot in event.docs) {
          Map<String, dynamic> map = snapshot.data();
          print("map =$map");
          Image_Slide imageslide = Image_Slide.fromMap(map);
          print("name = ${imageslide.image}");
          setState(() {
            widgests.add(creatWidget(imageslide));
          });
        }
      });
    });
  }

  Widget creatWidget(Image_Slide imageSlide) => CarouselSlider.builder(
        itemCount: 2,
        itemBuilder: (context, index, realIndex) {
          return Image.network(
            imageSlide.image,
            fit: BoxFit.fill,
            width: double.infinity,
          );
        },
        options: CarouselOptions(
          scrollDirection: Axis.horizontal,
          height: 250,
          enlargeCenterPage: true,
          autoPlayCurve: Curves.linear,
          autoPlay: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          reverse: false,
          onPageChanged: (index, reason) {
            setState(
              () {
                _currentIndex = index;
              },
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgests.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: widgests,
            ),
    );
  }
}
