import 'package:flutter/material.dart';
import 'package:oceanfocused/screens/size_config.dart';
import 'package:oceanfocused/widgets/timer.dart';
import 'package:simple_animations/simple_animations.dart';

class StackedWid extends StatefulWidget {
  @override
  _StackedWidState createState() => _StackedWidState();
}

class _StackedWidState extends State<StackedWid> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Stack(
      children: <Widget>[
        Container(
      height: MediaQuery. of(context). size. height - 30,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      tileMode: TileMode.mirror,
      begin: Alignment.topRight,
      end: Alignment(0.1, 1.0),
      colors: [
        Color(0xff201532),
        Color(0xff2079bf),
      ],
      stops: [
        0,
        1,
      ],
    ),
    backgroundBlendMode: BlendMode.srcOver,
  ),
  child: PlasmaRenderer(
    type: PlasmaType.infinity,
    particles: 10,
    color: Color(0x8e62aadc),
    blur: 0.64,
    size: 0.87,
    speed: 1.71,
    offset: 1.24,
    blendMode: BlendMode.screen,
    variation1: 0,
    variation2: 0,
    variation3: 0,
    rotation: -0.99,
  ),
    ),
    Center(
      child: SingleChildScrollView(
              child: Column(
          children: [
            SizedBox(height:20),
            TimerContainer(),
            SizedBox(height:50),
            
          ],
        ),
      ),
    ),
      ],
    );
  }
}