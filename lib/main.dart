import 'package:flutter/material.dart';
import 'package:snow_man/splash_screen.dart'; // Import the splash_screen.dart file
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My app',
      home: SplashScreen(), // Set SplashScreen as the initial route
    );
  }
}