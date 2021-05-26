import 'dart:async';
import 'package:flutter/material.dart';

import 'SignIn/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 4000), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
          colors: [Color(0xFFFAFAFA), Color(0xFFE0E0E0)],
          end: Alignment.bottomCenter
          ),
        ),
        child: Center(
          child: Image.asset(
            "images/GitMasters.png",
            width: 170,
            height: 170,
          ),
        ),
    ),
    );
  }
}