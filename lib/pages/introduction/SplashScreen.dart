import 'package:flutter/material.dart';
import 'dart:async';
import '../../utils/Routes.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.OnBoardingPageRoutes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              child: Image.asset(
                'assets/logo_fincopay.png',
                width: 300,
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
