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

  int navigationIndex = 0;

  final List<Color> navigationColors = [
    Colors.black54,
    Colors.redAccent,
    Colors.blueAccent
  ];

  final List<int> navigationTimes = [
    300,
    1500,
    1200
  ];

  void onTabTapped(int index) {
    setState(() {
      navigationIndex = index;
    });
  }

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
          backgroundColor: navigationColors[navigationIndex],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomTimeContainer(
                    label: 'Minutes', value: minutes.toString(),
                      color: navigationColors[navigationIndex]),
                  CustomTimeContainer(
                    label: 'Seconds', value: seconds.toString(),
                    color: navigationColors[navigationIndex]),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top:25),
                color: navigationColors[navigationIndex],
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
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: navigationIndex, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.filter_5),
              title: new Text('Just Five Minutes'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.timer),
              title: new Text('Traditional Pomodoro'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.laptop),
                title: Text('20/20/20')
            )
          ],
        ),
      ),
    );
  }
}
