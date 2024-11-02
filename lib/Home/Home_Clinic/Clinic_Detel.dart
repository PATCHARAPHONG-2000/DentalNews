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
      // Handle the error, show dialog or snackbar if needed
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
          maxLines: 3, // Unlimited lines
          overflow: TextOverflow.visible, // Allow text to wrap
          softWrap: true, // Enable text wrapping
          style: GoogleFonts.k2d(
            fontSize: fontSizeContent,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                  color: Colors.white, size: screenWidth * 0.05),
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
              child: Image.asset(
                "image/Head.png",
              ),
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
            _buildTextSection(
              tr('app.Time'),
              clinicData.time,
              screenWidth * 0.05,
              screenWidth * 0.045,
            ),
            const SizedBox(height: 20),
            _buildTextSection(
              tr('app.Time_Out'),
              clinicData.holidays,
              screenWidth * 0.05,
              screenWidth * 0.045,
            ),
          ],
        ),
      ),
    );
  }
}
