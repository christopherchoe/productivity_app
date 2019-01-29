import 'dart:async';
import 'package:flutter/material.dart';
import 'time_container_page.dart';

class TimerCustom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TimerCustomState();
  }
}

class TimerCustomState extends State<TimerCustom> {
  static const duration = const Duration(seconds:1);

  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;

  void incrementSecond() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  @override
  void initState() {
    timer = Timer.periodic(duration, (Timer t) {
      incrementSecond();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;

    return MaterialApp(
      title: 'Productivity Push',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Productivity Push'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTimeContainer(
                      label: 'Minutes', value: minutes.toString()),
                  CustomTimeContainer(
                      label: 'Seconds', value: seconds.toString()),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top:25),
                child: RaisedButton(
                  child: Text(isActive ? 'PAUSE' : 'START'),
                  onPressed: (){
                    setState(() {
                      isActive = !isActive;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}