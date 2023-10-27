import 'package:flutter/material.dart';
import 'package:mobile_fincopay/utils/Routes.dart';

class PasswordUpdatedPage extends StatefulWidget {
  @override
  State<PasswordUpdatedPage> createState() => _PasswordUpdatedPageState();
}

class _PasswordUpdatedPageState extends State<PasswordUpdatedPage> {
  bool iSButtonPressedPasswordChanged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              /*Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FractionallySizedBox(
                    heightFactor: 0.55,
                    child: Image.asset(
                      'assets/polygone4.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),*/
              Container(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.09), // espace en haut
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pushReplacementNamed(context, Routes.SettingsPageRoutes);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            //color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Container(
                      height: 60,
                      child: Image.asset(
                        'assets/fincodern.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Password Changed',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text(
                      "Congratulation you've successfully changed your password",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Container(
                      height: 130,
                      child: Image.asset(
                        'assets/done.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Container(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, Routes.SettingsPageRoutes);
                          setState(() {
                            iSButtonPressedPasswordChanged = !iSButtonPressedPasswordChanged;
                          });
                        },
                        child: Text(
                          'Back to Settings',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: iSButtonPressedPasswordChanged ? Colors.orangeAccent : Color(0xFF040034),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
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
