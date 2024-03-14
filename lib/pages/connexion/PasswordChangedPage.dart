import 'package:flutter/material.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/widgets/ReusableButtonWidgets.dart';

class PasswordChangedPage extends StatefulWidget {
  @override
  State<PasswordChangedPage> createState() => _PasswordChangedPageState();
}

class _PasswordChangedPageState extends State<PasswordChangedPage> {
  bool iSButtonPressedPasswordChanged = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.09), // espace en haut
                    Container(
                      padding: EdgeInsets.all(18.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pushNamedAndRemoveUntil(context, Routes.LoginPageRoutes, ModalRoute.withName('/createnewpassword'),);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 70,
                              child: Image.asset(
                                'assets/logo_fincopay.png',
                                width: 300,
                                height: 300,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.07),

                    Container(
                      padding: EdgeInsets.all(18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Password Changed',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(18.0),
                      child: Text(
                        "Congratulation you've successfully changed your password",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Container(
                      height: 130,
                      child: Image.asset(
                        'assets/done.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    ReusableButtonWidgets(
                      text: "Back to login",
                      fontSize: 14,
                      onPressed: (){
                        Navigator.pushNamedAndRemoveUntil(context, Routes.LoginPageRoutes, ModalRoute.withName('/createnewpassword'),);
                      },
                      color: Color(0xFF336699),
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
