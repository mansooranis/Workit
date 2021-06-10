
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart' as aud;
import "package:flutter/material.dart";
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:oceanfocused/screens/size_config.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';

class StudyTimerContainer extends StatefulWidget {
  @override
  _StudyTimerContainerState createState() => _StudyTimerContainerState();
}

class _StudyTimerContainerState extends State<StudyTimerContainer> {
  final data = GetStorage();
  final assetsAudioPlayer = aud.AssetsAudioPlayer();
  final assetsAudioPlayer2 = aud.AssetsAudioPlayer();
  bool ispressed =false;
  bool ispressed2 =false;
  bool isstartedff = false;
  bool isstartedf = false;
  int _seconds = 0;
  int _minutes = 25;
  final player = AudioPlayer();
  Timer _timer;
  final fmins = TextEditingController();
  final fsecs = TextEditingController();
  final bmins = TextEditingController();
  final bsecs = TextEditingController();
  String _dropDownValue;
  
  var f = NumberFormat("00");
  
 loopmusic()async{
   await player.setLoopMode(LoopMode.one);
 }

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

  playstopmusic(){
    if (ispressed2){
      player.pause();
      return Icons.pause;
    }else{
      player.play();
      return Icons.play_circle_fill_rounded;
    }
  }
      String songname = "Music for Study (1)";
    String songimageurl = 'https://cdn.pixabay.com/photo/2017/10/12/20/15/photoshop-2845779_960_720.jpg';
    String songurl = 'https://oceanfocused.s3.eu-west-3.amazonaws.com/assets/audio/%5BMP3FY%5D+No+Copyright+Lofi+Hip+Hop+2020+_+Chill+Lofi+Beats+Playlist+_+Japanese+Lofi+Music+%2314.mp3';
    playlofimusic()async{
    var duration = await player.setUrl(songurl);
    
    player.play();
  }

  savechanges ()async{
    var duration = await player.setUrl(songurl);
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
          assetsAudioPlayer2.open(aud.Audio("assets/audio/breakstart.mp3"));
          assetsAudioPlayer2.play();
          startTimer();      
          }else{
            _minutes = data.read("_fminutes");
          _seconds = data.read("_fseconds");
          data.write("isstartedf", true);
          assetsAudioPlayer2.open(aud.Audio("assets/audio/focusstart.mp3"));
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
  void initState() {
    data.write("_bminutes", 5);
    data.write("_bseconds", 0);
    data.write("_fminutes", 25);
    data.write("_fseconds", 0);
    data.write("songimageurl", 'https://cdn.pixabay.com/photo/2017/10/12/20/15/photoshop-2845779_960_720.jpg');
    data.write("songpath", 'assets/audio/music1.mp3');
    data.write("songurl",'https://oceanfocused.s3.eu-west-3.amazonaws.com/assets/audio/%5BMP3FY%5D+No+Copyright+Lofi+Hip+Hop+2020+_+Chill+Lofi+Beats+Playlist+_+Japanese+Lofi+Music+%2314.mp3');
    super.initState();
  }

  
  @override
  bool isSwitched = false;
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Stack(
      children: [Center(
    child: SingleChildScrollView(
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
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                        decoration: TextDecoration.none
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
                                                SizedBox(height: 15,),
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

                
              ],
            ),
            SizedBox(height: 50,),
            SizedBox(
              width: getProportionateScreenWidth(300),
              height: getProportionateScreenHeight(100),
              child: Container(
                child: Row(
                  children: [
                    SizedBox(width: 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(19.0),
                            child: Image(
                              fit: BoxFit.fill,
                              height: getProportionateScreenHeight(80),
                              width: getProportionateScreenWidth(80),
                              image: NetworkImage(
                                  songimageurl),
                            ),
                          ),
                        ],
                      ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            SizedBox(width:getProportionateScreenWidth(170),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 8, 0, 0),
                              child: Text(songname, textAlign: TextAlign.center,style: TextStyle(
                                  fontWeight: FontWeight.w300, 
                                  fontSize:10 , 
                                  color: Colors.white,
                                  decoration: TextDecoration.none
                                      )),
                            ),
                            )
                          ],
                        ),
                        
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius:  BorderRadius.circular(18.0),
                  color: Color(0xCC667B93),
              ),
              ), 
            ),
            Center(
              child: Container(
                height: getProportionateScreenHeight(50),
                width: getProportionateScreenWidth(300),
                decoration:  BoxDecoration(
                  borderRadius:  BorderRadius.circular(18.0),
                  
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 65,
                            width: 65,
                            child: FlatButton(
                            onPressed: () {
                              setState(() {
                                   playlofimusic();
                                   
                              });
                              },
                            
                            child: Icon(
                              
                            playstopmusic(),
                            size: 25.0,
                            color: Colors.white,
                            ),
                            
          ),
                          ),
                        ),
          Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                          height: 65,
                          width: 65,
                          child: FlatButton(
                            onPressed: () {
                              player.pause();
                            },
                            child: Icon(
                            Icons.stop,
                            color: Colors.white,
                            size: 25.0,
                            ),
                ),
                ),
          ),
          Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                          width: 65,
                          height: 65,
                          child: FlatButton(
                            onPressed: () {
                              return showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, setState){
                              return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                            contentPadding: EdgeInsets.only(top: 10.0),
                                            content: Container(
                                              width: getProportionateScreenWidth(300),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
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
                                                    SizedBox(height: 15,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Align(alignment: Alignment.centerLeft, child: 
                                                        Padding(
                                                          padding: const EdgeInsets.fromLTRB(10.0,0,0,0),
                                                          child: Text("Loop Music"),
                                                        )
                                                        ),
                                                        Align(alignment: Alignment.centerRight,
                                                        child: Switch(
                                                          value: isSwitched,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              isSwitched = value;
                                                              print(isSwitched);
                                                              if (isSwitched){
                                                                loopmusic();
                                                              }
                                                            });
                                                          }),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(10.0),
                                                      child: DropdownButton(
                                                        hint: _dropDownValue == null
                                                            ? Text('Select Music')
                                                            : Text(
                                                                _dropDownValue,
                                                                style: TextStyle(color: Colors.blue),
                                                              ),
                                                        isExpanded: true,
                                                        iconSize: 30.0,
                                                        style: TextStyle(color: Colors.blue),
                                                        items: ['Music for Study (1)', 'Music for Study (2)', 'Music for Study (3)'].map(
                                                          (val) {
                                                            return DropdownMenuItem<String>(
                                                              value: val,
                                                              child: Text(val),
                                                            );
                                                          },
                                                        ).toList(),
                                                        onChanged: (val) {
                                                          WidgetsBinding.instance.addPostFrameCallback((_) => setState(
                                                            () {
                                                              _dropDownValue = val;
                                                              if (_dropDownValue == 'Music for Study (1)'){
                                                                
                                                                songname = _dropDownValue;
                                                                songimageurl = 'https://cdn.pixabay.com/photo/2017/10/12/20/15/photoshop-2845779_960_720.jpg';
                                                                songurl = 'https://oceanfocused.s3.eu-west-3.amazonaws.com/assets/audio/%5BMP3FY%5D+No+Copyright+Lofi+Hip+Hop+2020+_+Chill+Lofi+Beats+Playlist+_+Japanese+Lofi+Music+%2314.mp3';
                                                              } else if (_dropDownValue == 'Music for Study (2)'){
                                                                
                                                                songname = _dropDownValue;
                                                                songimageurl = 'https://images.unsplash.com/photo-1501504905252-473c47e087f8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=2767&q=80';
                                                                songurl = 'https://oceanfocused.s3.eu-west-3.amazonaws.com/assets/audio/Weekend+Relaxation+►+Jazz+Hop+%E2%88%95+Hip+Hop+%E2%88%95+Chill+Mix.mp3';
                                                              }else if (_dropDownValue == 'Music for Study (3)'){
                                                                songname = _dropDownValue;
                                                                songimageurl = 'https://images.unsplash.com/photo-1419640303358-44f0d27f48e7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1276&q=80';
                                                                songurl = 'https://oceanfocused.s3.eu-west-3.amazonaws.com/assets/audio/Lofi+Beat+Mix+25+%7C+4+Hour+Lo-fi+Mix+%5BNon+Copyright%5D+%7C+DMCA+FREE+For+Sleep%2C+Study%2C+%26+Streaming.mp3';
                                                              }
                                                            },
                                                          ));
                                                        },
                                                      ),
                                                    ),

                                                    InkWell(
                                                      onTap: (){
                                                        savechanges();
                                                        playlofimusic();
                                                        playstop();
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
                                            ),
                                      );
                                    }
                                  );
                                }
                              );
                            },
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 25.0,
                            ),
                          ),
                ),
          ),
                      ],
                    ),
              ),
            ),
            
        ],
      ),
    ),
        ),
          
      ]);
  }
}