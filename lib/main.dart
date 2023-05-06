import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home/Home.dart';
import 'ThemeMode/AppTheme.dart';
import 'ThemeMode/ThemeProvider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Dental_News());
}

// ignore: camel_case_types
class Dental_News extends StatelessWidget {
  const Dental_News({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          theme: themeProvider.isDarkTheme ? themeDataLight : themeDataDark,
          debugShowCheckedModeBanner: false,
          home: const Home(),
        ),
      ),
    );
  }
}
