import 'package:flutter/material.dart';
import 'weather.dart';
import 'navigate.dart';

void main() {
  runApp(const MaterialApp(home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({
    super.key,
  });

  @override
  MainAppState createState() => MainAppState();
}

class MainAppState extends State<MainApp> with NavigateWeather<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
      ),
    );
  }
}
