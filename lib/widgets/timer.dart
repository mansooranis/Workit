import 'package:assets_audio_player/assets_audio_player.dart';
import "package:flutter/material.dart";
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:oceanfocused/screens/size_config.dart';

class TimerContainer extends StatefulWidget {
  @override
  _TimerContainerState createState() => _TimerContainerState();
}

class _TimerContainerState extends State<TimerContainer> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool ispressed =false;
  int _seconds = 10;
  int _minutes = 0;
  Timer _timer;
  var f = NumberFormat("00");

  void stopTimer(){
      if (_timer!=null){
        _timer.cancel();
        _seconds = 0;
        _minutes = 25;
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
          _minutes = 25;
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
                      onPressed: () { startTimer();},
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.play_arrow,
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