import 'package:dental_news/Contoller/Color.dart';
import 'package:dental_news/Data/List_Title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dental_Benefitsr extends StatefulWidget {
  const Dental_Benefitsr({Key? key}) : super(key: key);

  @override
  _Dental_BenefitsrState createState() => _Dental_BenefitsrState();
}

class _Dental_BenefitsrState extends State<Dental_Benefitsr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "สิทธิประโยชน์ทางทันตกรรม ปี 2551",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: volunteere.length,
          itemBuilder: (context, index) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        volunteere[index].name,
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
                    volunteere[index].lebbel,
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
