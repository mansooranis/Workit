import 'package:flutter/material.dart';
import 'package:oceanfocused/screens/size_config.dart';
import 'package:oceanfocused/widgets/relaxtimer.dart';


class RelaxPage extends StatefulWidget {

  @override
  _RelaxPageState createState() => _RelaxPageState();
}

class _RelaxPageState extends State<RelaxPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/relax.jpg'),
            fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: getProportionateScreenHeight(100),),
                Container(
                  child: Text("Relax", textAlign: TextAlign.center,
                  style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 38, 
                  color: Colors.white,
                  decoration: TextDecoration.none
                      )
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(90),),
                RelaxTimerContainer()
                
                
              ],
            ),
          ),
      ),
    );
  }
}