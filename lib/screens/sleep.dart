import 'package:flutter/material.dart';
import 'package:oceanfocused/screens/size_config.dart';
import 'package:oceanfocused/widgets/sleeptimer.dart';
class SleepPage extends StatefulWidget {

  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sleep.jpg'),
            fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: getProportionateScreenHeight(100),),
                Container(
                  child: Text("Sleep", textAlign: TextAlign.center,
                  style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 38, 
                  color: Colors.white,
                  decoration: TextDecoration.none
                      )
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(90),),
                SleepTimerContainer()
                
                
              ],
            ),
          ),
      ),
    );
  }
}