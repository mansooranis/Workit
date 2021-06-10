import 'package:flutter/material.dart';
import 'package:oceanfocused/screens/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';

SharedPreferences sp;
void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ocean Focused',
      home: HomeScreen(),
    );
  }
}
