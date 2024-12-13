import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:line_icons/line_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../Firebase/Dental_Clinic.dart';

class Clinic_Detel extends StatelessWidget {
  final ClinicFirebase clinicData;

  const Clinic_Detel({super.key, required this.clinicData});

  Future<void> _launchUrl(Uri uri) async {
    try {
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Widget _buildTextSection(String title, String content, double fontSizeTitle,
      double fontSizeContent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.k2d(
            fontSize: fontSizeTitle,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          content,
          maxLines: 3,
          overflow: TextOverflow.visible,
          softWrap: true,
          style: GoogleFonts.k2d(
            fontSize: fontSizeContent,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingDaysSection(double fontSizeTitle, double fontSizeContent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tr('app.Time'), // หัวข้อเวลา
          style: GoogleFonts.k2d(
            fontSize: fontSizeTitle,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 10),
        // วนลูปแสดงวันและเวลา
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: clinicData.workingDays.map((dayData) {
              final day = dayData['day'] ?? '';
              final openTime = dayData['openTime'] ?? '';
              final closeTime = dayData['closeTime'] ?? '';
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  '$day: $openTime - $closeTime',
                  style: GoogleFonts.k2d(
                    fontSize: fontSizeContent,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(clinicData.name),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Theme.of(context).dividerColor,
        leading: IconButton(
          icon: const Icon(LineIcons.chevronCircleLeft),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(LineIcons.directions,
                  color: Colors.white, size: screenWidth * 0.07),
              onPressed: () => _launchUrl(Uri.parse(clinicData.map)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("image/Head.png"),
            ),
            const SizedBox(height: 40),
            Text(
              clinicData.name,
              style: GoogleFonts.k2d(
                fontSize: screenWidth * 0.06,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextSection(
              tr('app.Address'),
              clinicData.address,
              screenWidth * 0.05,
              screenWidth * 0.045,
            ),
            const SizedBox(height: 20),
            // เรียกฟังก์ชันแสดงวันและเวลาทำการ
            _buildWorkingDaysSection(screenWidth * 0.05, screenWidth * 0.045),
          ],
        ),
      ),
    );
  }
}
