import 'dart:async';
import 'package:flutter/material.dart';
import 'time_container_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  int navigationIndex =0;

  final List<Color> navigationColors = [
    Colors.black54,
    Colors.redAccent,
    Colors.blueAccent
  ];

  final List<String> timerMessages = [
    "Five minutes done, keep going!",
    "Pomodoro done, take a five minute break!",
    "Look twenty feet away for twenty seconds!",
    "Just Five Minutes",
    "Pomodoro",
    "20/20/20"
  ];

  final List<int> navigationTimes = [
    3,
    5,
    12
  ];

  int workTimer = 0;

  void onTabTapped(int index) {
    setState(() {
      navigationIndex = index;
    });
  }

  void incrementSecond() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
        if (secondsPassed >= workTimer)
          {
            showNotificationWithDefaultSound();
            isActive = false;
            secondsPassed = 0;
          }
      });
    }
  }

  Future showNotificationWithDefaultSound() async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      timerMessages[navigationIndex + 3],
      timerMessages[navigationIndex],
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
          title: const Text("Here is your payload"),
          content: new Text("Payload: $payload"),
      ),
    );
  }

  @override
  void initState() {

    timer = Timer.periodic(duration, (Timer t) {
      incrementSecond();
    });
    super.initState();

    var initializationSettingsAndroid =
    new AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {

    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;

    workTimer = navigationTimes[navigationIndex];

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
              Container(
                margin: EdgeInsets.only(top:25, bottom: 45),
                color: navigationColors[navigationIndex],
                child: RaisedButton(
                  child: Text('RESET'),
                  onPressed: (){
                    setState(() {
                      secondsPassed = 0;
                      isActive = false;
                    });
                  },
                ),
              ),
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
                margin: EdgeInsets.only(top:45),
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
