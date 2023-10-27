import 'package:flutter/material.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/widgets/ReusableButtonWidgets.dart';

class DiscoverPage extends StatefulWidget {
  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  bool isButtonPressedSignUp = false;
  bool iSButtonPressedSignIn = false;
  bool isButtonPressedLoginwithphonenumber = false;
  bool isButtonPressedSkipfornow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(13.0),
                child: Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.16
                    ),
                    Container(
                      height: 70,
                      child: Image.asset(
                        'assets/logo_fincopay.png',
                        width: 300,
                        height: 300,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.13),
                    Text(
                      'DISCOVER AMAZING THINGS AROUND YOU',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    ReusableButtonWidgets(
                        text: "Login",
                        textColor: Colors.white,
                        color: Color(0xFF336699),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.LoginPageRoutes);
                        },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                    ReusableButtonWidgets(
                        text: "Sign Up",
                        borderColor: Color(0xFF336699),
                        borderWidth: 1.5,
                        textColor: Color(0xFF336699),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.SignUpPagePageRoutes);
                        },
                        color: Colors.white
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.LoginWithOTPPageRoutes);
                              setState(() {
                                isButtonPressedLoginwithphonenumber =
                                !isButtonPressedLoginwithphonenumber;
                              });
                            },
                            child: Text(
                              'Login With Phone number',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF336699),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
