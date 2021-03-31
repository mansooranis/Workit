import "package:flutter/material.dart";
import 'dart:async';
import 'package:intl/intl.dart';

class TimerContainer extends StatefulWidget {
  @override
  _TimerContainerState createState() => _TimerContainerState();
}

class _TimerContainerState extends State<TimerContainer> {
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
    return Center(
      child: Column(
        children: [
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
          ElevatedButton(onPressed: (){startTimer();}, child: Text("Start")),
        ],
      ),
    );
  }
}