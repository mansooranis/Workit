import 'package:flutter/material.dart';
import 'package:oceanfocused/widgets/stackedWid.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StackedWid(),
    );
  }
}


