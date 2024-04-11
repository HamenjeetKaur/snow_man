import 'package:flutter/material.dart';
import 'dart:async';
import 'package:snow_man/login.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IntroPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
// Background image or color
          Container(
            decoration: BoxDecoration(
// You can use an image here or just a solid color
              color: Colors.black, // Change it to your desired color
            ),
          ),
// Logo
          Positioned(
            top: MediaQuery
                .of(context)
                .size
                .height * 0.2,
            left: MediaQuery
                .of(context)
                .size
                .width * 0.3,
            child: Image.asset(
              'assets/imG.jpg', // Replace with your image path
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.4,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.5,
// You may need to adjust width and height accordingly
            ),
          ),
// Text
          Positioned(
            bottom: 50.0,
            left: 0,
            right: 0,
            child: Text(
              'SNOW-MAN',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white, // Change it to your desired color
                fontSize: 30.0, // Adjust font size as needed
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}