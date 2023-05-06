import 'package:dental_news/Firebase/Jason_Toothache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class Toothache_Detel extends StatefulWidget {
  Toothache toothache;
  Toothache_Detel({super.key, required this.toothache});

  @override
  State<Toothache_Detel> createState() => _Toothache_DetelState();
}

class _Toothache_DetelState extends State<Toothache_Detel> {
  late Toothache toothache;
  List<Widget> widgests = [];

  @override
  void initState() {
    super.initState();
    toothache = widget.toothache;
    // readData();
    //detelDeata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: color.appBar,
      appBar: AppBar(
        title: Text(toothache.name == null ? ' ' : toothache.name),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(toothache.image),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  Text(
                    toothache.name,
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
                toothache.data,
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
