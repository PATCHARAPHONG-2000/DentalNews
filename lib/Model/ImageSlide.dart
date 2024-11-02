import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageSlide extends StatefulWidget {
  const ImageSlide({super.key});

  @override
  State<ImageSlide> createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {
  List<ImageProvider> imageProviders = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Dental_Image_slide")
        .orderBy("image")
        .get();

    final List<ImageProvider> providers = [];
    for (final DocumentSnapshot doc in snapshot.docs) {
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final imageUrl = data['image'] as String;
      final provider = NetworkImage(imageUrl);
      providers.add(provider);
    }

    if (mounted) {
      // Check if the widget is still mounted before calling setState
      setState(() {
        imageProviders = providers;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: imageProviders.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).hoverColor,
              ),
            )
          : CarouselSlider(
              items: imageProviders.map((provider) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: provider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              options: CarouselOptions(
                height: 250,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 8),
                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.4,
                onPageChanged: (index, reason) {
                  setState(() {});
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
    );
  }
}
