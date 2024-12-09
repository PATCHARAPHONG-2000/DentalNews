import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'Main_Bottom.dart';
import 'ThemeMode/AppTheme.dart';
import 'ThemeMode/ThemeProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBzj617iVSZl_Fuc_bHwccmcpAB1WZkU3A",
      projectId: "dentalnews-657c1",
      messagingSenderId: '746041165202',
      storageBucket: 'dentalnews-657c1.appspot.com',
      appId: "1:746041165202:android:0abf953d7f1342337e6d4b",
    ),
  );

  await FlutterDownloader.initialize(debug: true);

  await EasyLocalization.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  // ตั้งค่าเริ่มต้นเป็นภาษาไทย
  bool languageSwitchValue = prefs.getBool('languageSwitchValue') ?? false;
  Locale initialLocale =
      languageSwitchValue ? const Locale('en') : const Locale('th');
  bool isDarkTheme = prefs.getBool('isDarkTheme') ?? false;

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('th'), Locale('en')],
      path: 'assets/translations',
      saveLocale: true,
      fallbackLocale: const Locale('th'), // ตั้งภาษาไทยเป็น fallback
      startLocale: initialLocale, // ตั้งค่า initialLocale
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider()..setDarkTheme(isDarkTheme),
        child: const DentalNewsApp(),
      ),
    ),
  );
}

class DentalNewsApp extends StatelessWidget {
  const DentalNewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: Provider.of<ThemeProvider>(context).isDarkTheme
          ? themeDataDark
          : themeDataLight,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}
