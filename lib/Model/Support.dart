// ignore: file_names
import 'dart:io';
import 'package:dentalnews/Home/Call/caal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ThemeMode/ThemeProvider.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({super.key});

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  bool _languageSwitchValue = false;
  late SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> openPDF(BuildContext context) async {
    try {
      // โหลดไฟล์จาก assets
      final byteData = await rootBundle.load('assets/pdf/Application.pdf');

      // สร้างไฟล์ชั่วคราวใน directory ของแอป
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/Application.pdf');

      // เขียนไฟล์ PDF ลงในระบบไฟล์
      await tempFile.writeAsBytes(byteData.buffer.asUint8List());

      // เปิดไฟล์ PDF โดยใช้แพ็กเกจ open_file
      await OpenFile.open(tempFile.path);
    } catch (e) {
      // Handle the error
      if (kDebugMode) {
        print("Could not open PDF file: $e");
      }
    }
  }

  Future<void> _loadPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    _languageSwitchValue = _preferences.getBool('languageSwitchValue') ?? false;
    setState(() {});
  }

  Future<void> changeLanguage(bool value) async {
    if (_languageSwitchValue != value) {
      setState(() {
        _languageSwitchValue = value;
      });
      if (value) {
        await context.setLocale(const Locale('en'));
      } else {
        await context.setLocale(const Locale('th'));
      }
      await _preferences.setBool('languageSwitchValue', value);
    }
  }

  Widget _languageSwitch() {
    if (Platform.isIOS) {
      return CupertinoSwitch(
        onChanged: (value) => changeLanguage(value),
        value: _languageSwitchValue,
      );
    } else {
      return Switch(
        onChanged: (value) => changeLanguage(value),
        value: _languageSwitchValue,
      );
    }
  }

  Widget _themeSwitch() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Switch(
        onChanged: (value) {
          themeProvider.changeTheme();
          SharedPreferences.getInstance().then((prefs) {
            prefs.setBool('isDarkTheme', themeProvider.isDarkTheme);
          });
        },
        value: themeProvider.isDarkTheme,
        activeColor: Theme.of(context).hoverColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.locale; // ให้ EasyLocalization ติดตามการเปลี่ยนแปลงภาษา
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(
                screenWidth * 0.05), // ปรับ padding ให้เป็น responsive
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  maxRadius: screenWidth * 0.2, // ปรับขนาดตาม screen width
                  backgroundImage: const AssetImage('image/head_support.png'),
                ),
                Padding(
                  padding: EdgeInsets.all(screenHeight * 0.02), // ปรับ padding
                  child: Text(
                    'D E N T A L  N E W S',
                    style: TextStyle(
                      fontSize:
                          screenWidth * 0.08, // ปรับขนาดฟอนต์ให้เป็น responsive
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).splashColor,
                    ),
                  ),
                ),
                const Divider(height: 50),
                _buildListTile(
                  context,
                  screenWidth,
                  screenHeight,
                  title: tr('app.Language'),
                  subtitle: tr('app.LanguageDetel'),
                  icon: 'image/language.png',
                  trailing: _languageSwitch(),
                ),
                const Divider(),
                _buildListTile(
                  context,
                  screenWidth,
                  screenHeight,
                  title: tr('app.Theme'),
                  subtitle: tr('app.Themesetting'),
                  icon: 'image/theme.png',
                  trailing: _themeSwitch(),
                ),
                const Divider(),
                _buildListTile(
                  context,
                  screenWidth,
                  screenHeight,
                  title: tr('app.Manual'),
                  subtitle: tr('app.ManualTitle'),
                  icon: 'image/setting.png',
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () => openPDF(context), // เรียกฟังก์ชันที่แก้ไขแล้ว
                ),
                const Divider(),
                _buildListTile(
                  context,
                  screenWidth,
                  screenHeight,
                  title: tr('app.Help'),
                  subtitle: tr('app.HelpTile'),
                  icon: 'image/service.png',
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const Call();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build ListTile
  Widget _buildListTile(
    BuildContext context,
    double screenWidth,
    double screenHeight, {
    required String title,
    required String subtitle,
    required String icon,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: GoogleFonts.k2d(
          textStyle: TextStyle(
            fontSize: screenWidth * 0.045, // Responsive font size
            fontWeight: FontWeight.w500,
            color: Theme.of(context).splashColor,
          ),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.k2d(
          textStyle: TextStyle(
            fontSize: screenWidth * 0.04, // Responsive font size
            fontWeight: FontWeight.w500,
            color: Theme.of(context).splashColor,
          ),
        ),
      ),
      leading: Image.asset(
        icon,
        width: screenWidth * 0.09, // Responsive icon size
        height: screenHeight * 0.05, // Responsive icon size
      ),
      trailing: trailing,
    );
  }
}
