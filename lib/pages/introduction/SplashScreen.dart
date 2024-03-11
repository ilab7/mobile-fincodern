import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var userCtrl = context.read<UserController>();

    Timer(Duration(seconds: 2), () {
      if(userCtrl.isFirstTimeBienvenue){
        Navigator.pushReplacementNamed(context, Routes.LoginPageRoutes);
      } else {
        Navigator.pushReplacementNamed(context, Routes.OnBoardingPageRoutes);
      }
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
