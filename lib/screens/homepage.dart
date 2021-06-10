import 'package:flutter/material.dart';
import 'package:oceanfocused/screens/relax.dart';
import 'package:oceanfocused/screens/size_config.dart';
import 'package:oceanfocused/screens/sleep.dart';
import 'package:oceanfocused/screens/study.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dataKey = new GlobalKey();

  

  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/homepage.jpg'),
            fit: BoxFit.fill,
          ),
          ),
      child: 
         SafeArea(
           child: Column(
             children: <Widget>[
               SizedBox(height:getProportionateScreenHeight(70)),
               Container(
                 child: Text(
                 """Pick Your \nMood""", 
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   fontWeight: FontWeight.normal, 
                   fontSize: 39, 
                   color: Colors.white,
                   decoration: TextDecoration.none
                       )
                     )
                   ),
                  SizedBox(height: 120,),
                 Center(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => SleepPage()),);
                           },
                           child: Container(
                             height: getProportionateScreenHeight(200),
                             width: getProportionateScreenWidth(100),
                             decoration:  BoxDecoration(
                             borderRadius:  BorderRadius.circular(46.0),
                             color: Color(0xCC667B93),
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               Icon(Icons.bed, size: 35,),
                               SizedBox(height: getProportionateScreenHeight(10),),
                               Text("Sleep",textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 16,
                                  color: Colors.white,
                                  decoration: TextDecoration.none
                                      ))
                             ],
                           ),
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => StudyPage()),);
                           },
                           child: Container(
                             height: getProportionateScreenHeight(200),
                             width: getProportionateScreenWidth(100),
                             decoration:  BoxDecoration(
                             borderRadius:  BorderRadius.circular(46.0),
                             color: Color(0xCC667B93),
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               Icon(Icons.edit_rounded,size: 35,),
                               SizedBox(height:getProportionateScreenHeight(10)),
                               Text("Study",textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 16,
                                  color: Colors.white,
                                  decoration: TextDecoration.none
                                      ))
                             ],
                           ),
                           ),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: GestureDetector(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => RelaxPage()),);
                           },
                           child: Container(
                             height: getProportionateScreenHeight(200),
                             width: getProportionateScreenWidth(100),
                             decoration:  BoxDecoration(
                             borderRadius:  BorderRadius.circular(46.0),
                             color: Color(0xCC667B93),
                           ),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               Icon(Icons.mood_sharp, size: 35,),
                               SizedBox(height: getProportionateScreenHeight(10),),
                               Text("Relax",textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, 
                                  fontSize: 16, 
                                  color: Colors.white,
                                  decoration: TextDecoration.none
                                      ))
                             ],
                           ),
                           ),
                         ),
                       ),
                     ],
                   ),
                 )
             ],
           ),
         )
        ,),
    
      
    );
  }
}


