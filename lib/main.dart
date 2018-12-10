import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Flutter Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  void resetTimer() {
    setState(() {
      secondsPassed = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null)
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });

    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextContainer(
                    label: 'HRS', value: hours.toString().padLeft(2, '0')),
                CustomTextContainer(
                    label: 'MIN', value: minutes.toString().padLeft(2, '0')),
                CustomTextContainer(
                    label: 'SEC', value: seconds.toString().padLeft(2, '0')),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: RaisedButton(
                  textColor: Colors.teal,
                  child: Text(isActive ? 'STOP' : "START"),
                  onPressed: () {
                    setState(() {
                      isActive = !isActive;
                    });
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            resetTimer();
            if (isActive) {
              isActive = !isActive;
            }
          });
        },
        tooltip: 'RESET',
        child: Icon(Icons.restore),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}

class CustomTextContainer extends StatelessWidget {
  CustomTextContainer({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(20),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.circular(10), color: Colors.black54),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
                color: Colors.white, fontSize: 54, fontWeight: FontWeight.bold),
          ),
          Text('$label',
              style: TextStyle(
                color: Colors.white,
              ))
        ]));
  }
}
