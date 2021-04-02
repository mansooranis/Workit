import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import "package:flutter/material.dart";
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:oceanfocused/screens/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';

class TimerContainer extends StatefulWidget {
  @override
  _TimerContainerState createState() => _TimerContainerState();
}

class _TimerContainerState extends State<TimerContainer> {
  final data = GetStorage();
  final assetsAudioPlayer = AssetsAudioPlayer();
  final assetsAudioPlayer2 = AssetsAudioPlayer();
  bool ispressed =false;
  bool isstartedff = false;
  bool isstartedf = false;
  int _seconds = 0;
  int _minutes = 25;


  Timer _timer;
  final fmins = TextEditingController();
  final fsecs = TextEditingController();
  final bmins = TextEditingController();
  final bsecs = TextEditingController();
  var f = NumberFormat("00");

  void stopTimer(){
      if (_timer!=null){
        _timer.cancel();
        
          
        
        /*_seconds = data.read("_fseconds");
        _minutes = data.read("_fminutes"); */
        
      }else if(isstartedff == true){
        try{
          setState(() {
             _seconds = data.read("_fseconds");
            _minutes = data.read("_fminutes");
          });
       
      } on Exception{
        setState(() {
          _seconds = 0;
        _minutes = 25;
        });
        
      }
      isstartedff = false;
      data.write("isstartedf", false);
      _timer.cancel();
      
      }
  }
  
  playstop (){
    if (isstartedf){
      return Icons.pause;
    }else {
      return Icons.play_arrow;
    }
  }

  void startTimer(){
    if (_timer != null){
      stopTimer();
    }
  if (_minutes > 0){
  _seconds = _minutes * 60;
  }
  if (_seconds >60){
  _minutes = (_seconds/60).floor();
  _seconds -= (_minutes * 60);
  }
  _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    setState(() {
      if (_seconds > 0){
        _seconds--;
      }
      else {
        if (_minutes >0){
          _seconds = 59;
          _minutes--;
        }
        else {
          _timer.cancel();
          if (data.read("isstartedf")){
          _minutes = data.read("_bminutes");
          _seconds = data.read("_bseconds");
          data.write("isstartedf", false);
          assetsAudioPlayer2.open(Audio("assets/audio/breakstart.mp3"));
          assetsAudioPlayer2.play();
          startTimer();      
          }else{
            _minutes = data.read("_fminutes");
          _seconds = data.read("_fseconds");
          data.write("isstartedf", true);
          assetsAudioPlayer2.open(Audio("assets/audio/focusstart.mp3"));
          assetsAudioPlayer2.play();
          startTimer();
          }
          print("Timer Complete");
        }
      }
    });
  });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${f.format(_minutes)} : ${f.format(_seconds)}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 48,
                        ),
                      ),
                    ],
                  ),
            ),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RawMaterialButton(
                      onPressed: () { 
                      if(isstartedf == false){
                        startTimer();
                        setState(() {
                          isstartedf = true;
                        });
                        isstartedff = true;
                        data.write("isstartedf", true);
                      }else{
                        stopTimer();
                        setState(() {
                          isstartedf = false;
                        });
                      }
                      },
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        playstop(),
                        size: 15.0,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                  RawMaterialButton(
                    onPressed: () {
                      _timer.cancel();
                      setState(() {
                        data.writeIfNull("fminutes", 25);
                        data.writeIfNull("fseconds", 0);
                        _minutes = data.read("fminutes");
                        _seconds = data.read('fseconds');
                        data.write("isstartedf", true);
                        isstartedf = false;
                      });
                    },
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.stop,
                      size: 15.0,
                    ),
                    padding: EdgeInsets.all(15.0),
                    shape: CircleBorder(),
                    ),

                  RawMaterialButton(
                      onPressed: () {
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                            contentPadding: EdgeInsets.only(top: 10.0),
                                            content: Container(
                                              width: 300.0,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  RawMaterialButton(
                                                    onPressed: () {Navigator.pop(context);},
                                                    elevation: 2.0,
                                                    fillColor: Colors.white,
                                                    child: Icon(
                                                      Icons.close,
                                                      size: 15.0,
                                                    ),
                                                    padding: EdgeInsets.all(15.0),
                                                    shape: CircleBorder(),
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Divider(
                                                    color: Colors.grey,
                                                    height: 4.0,
                                                  ),
                                                  SizedBox(height:10),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
                                                    child: Text("Focus Time:"),
                                                  ),
                                                  SizedBox(height:10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.black),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: TextField(
                                                          controller: fmins,
                                                          keyboardType: TextInputType.number,
                                                          textAlign: TextAlign.center,
                                                          decoration: InputDecoration(
                                                            hintText: "mins",
                                                            hintStyle: TextStyle(fontSize: 15),
                                                            border: InputBorder.none,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5,),
                                                      Text(":"),
                                                      SizedBox(width: 5,),
                                                      Container(
                                                        height: 50,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.black),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: TextField(
                                                          controller: fsecs,
                                                         keyboardType: TextInputType.number,
                                                          textAlign: TextAlign.center,
                                                          decoration: InputDecoration(
                                                            hintText: "secs",
                                                            hintStyle: TextStyle(fontSize: 15),
                                                            border: InputBorder.none,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height:10),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(8.0,0,0,0),
                                                    child: Text("Break Time:"),
                                                  ),
                                                  SizedBox(height:10),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.black),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: TextField(
                                                          keyboardType: TextInputType.number,
                                                          textAlign: TextAlign.center,
                                                          controller: bmins,
                                                          decoration: InputDecoration(
                                                            hintText: "mins",
                                                            hintStyle: TextStyle(fontSize: 15),
                                                            border: InputBorder.none,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5,),
                                                      Text(":"),
                                                      SizedBox(width: 5,),
                                                      Container(
                                                        height: 50,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.black),
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                        child: TextField(
                                                          keyboardType: TextInputType.number,
                                                          textAlign: TextAlign.center,
                                                          controller: bsecs,
                                                          decoration: InputDecoration(
                                                            hintText: "secs",
                                                            hintStyle: TextStyle(fontSize: 15),
                                                            border: InputBorder.none,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                  InkWell(
                                                    onTap: (){
                                                      setState(() {
                                                        if (fmins.text == ''){
                                                          _minutes = 0;
                                                          data.write("_fminutes", 0);
                                                        }else{
                                                          _minutes = int.parse(fmins.text);
                                                          data.write("_fminutes", int.parse(fmins.text));
                                                        }
                                                        
                                                        if (fsecs.text == ""){
                                                          _seconds = 0;
                                                          data.write("_fseconds", 0);
                                                        }else{
                                                          _seconds = int.parse(fsecs.text);
                                                          data.write("_fseconds", int.parse(fsecs.text));
                                                        }

                                                        if (bmins.text == ""){
                                                         
                                                          data.write("_bminutes", 0);
                                                        } else{
                                                         
                                                          data.write("_bminutes", int.parse(bmins.text));
                                                          
                                                        }

                                                        if (bsecs.text == ""){
                                                          
                                                          data.write("_bseconds", 0);
                                                        } else{
                                                          
                                                          data.write("_bseconds", int.parse(bsecs.text));
                                                        }
                                                        
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                                                      decoration: BoxDecoration(
                                                        color: Colors.blue[800],
                                                        borderRadius: BorderRadius.only(
                                                            bottomLeft: Radius.circular(32.0),
                                                            bottomRight: Radius.circular(32.0)),
                                                      ),
                                                      child: Text(
                                                        "Save",
                                                        style: TextStyle(color: Colors.white),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                            );});},
                                          
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.edit,
                        size: 15.0,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),

                  RawMaterialButton(
                      onPressed: () { startTimer();},
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.settings,
                        size: 15.0,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                ],
              ),
              SizedBox(height: 50,),
              SizedBox(
                width: getProportionateScreenWidth(300),
                height: getProportionateScreenHeight(60),
                child: Container(
                  child: Row(
                    children: [
                      RawMaterialButton(
                      onPressed: () {assetsAudioPlayer.open(Audio("assets/audio/music1.mp3"));
                        setState(() {
                          if (ispressed == false){
                            assetsAudioPlayer.play();
                            ispressed = true;
                          }else if(ispressed == true){
                            assetsAudioPlayer.stop();
                            ispressed = false;
                          }
                        });
                        },
                      elevation: 2.0,
                      fillColor: Colors.white70,
                      child: Icon(
                      Icons.play_circle_fill,
                      size: 15.0,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                    RawMaterialButton(
                      onPressed: () {
                        try{
                        assetsAudioPlayer.stop();}
                        catch (t){

                        };
                        },
                      elevation: 2.0,
                      fillColor: Colors.white70,
                      child: Icon(
                      Icons.pause,
                      size: 15.0,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    )
                    ],
                  ),
                  decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.blueGrey[100]
                ),
                ), 
              ),
              
          ],
        ),
      ),
              
          ]);
  }
}