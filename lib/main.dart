import 'package:flutter/material.dart';
import 'package:goltest_ebay/ui/screen/weather_widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Golden Test Demo',
      home: Scaffold(body: WeatherForecast()),
    );
  }
}
