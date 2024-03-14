import 'package:flutter/material.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/pages/connexion/VerifyOtpForgotPasswordPage.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/widgets/ChargementWidget.dart';
import 'package:mobile_fincopay/widgets/CustomVisibilityWidget.dart';
import 'package:mobile_fincopay/widgets/EntryFieldEmailWidgets.dart';
import 'package:mobile_fincopay/widgets/MessageWidgets.dart';
import 'package:mobile_fincopay/widgets/ReusableButtonWidgets.dart';
import 'package:provider/provider.dart';

class ForgotYourPassword extends StatefulWidget {
  @override
  State<ForgotYourPassword> createState() => _ForgotYourPasswordState();
}

class _ForgotYourPasswordState extends State<ForgotYourPassword> {
  bool iSButtonPressedSendaCode = false;
  bool Backtologin = false;

  var email = TextEditingController();
  var password = TextEditingController();
  var appName = "FINCOPAY";

  String? userId; // Declare the userId variable here

  bool isLoadingWaitingAPIResponse = false;

  //CustomVisibility Bloc variable
  bool isCancelButtonVisible = false;

  bool isVisible = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            _body(context),
            ChargementWidget(isVisible),
          ],
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(06.0),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.12), // espace en haut
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context, Routes.LoginPageRoutes);
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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Forgot your password',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Please enter your email address to Verify Email, for security reasons',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                  EntryFieldEmailWidgets(
                    ctrl: email,
                    required: true,
                    label: "Email",
                    isEmail: false,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  ReusableButtonWidgets(
                    text: "Verify email",
                    fontSize: 14,
                    onPressed: isLoadingWaitingAPIResponse ? null : _handleSignUpPressed,
                    color: Color(0xFF336699),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context, Routes.LoginPageRoutes);
                              setState(() {
                                Backtologin = !Backtologin;
                              });
                            },
                            child: Text(
                              'Back to Login',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),

                        CustomVisibilityWidget(
                          visible: isCancelButtonVisible,
                          onPressed: () {
                            setState(() {
                              isCancelButtonVisible = false;
                              isLoadingWaitingAPIResponse = false;
                            });
                          },
                          child: Text(
                            'Cancel query',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.red,
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
    );
  }

  Future<void> VerifyEmailPressed() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!formKey.currentState!.validate()) {
      return;
    }

    isVisible = true;
    setState(() {
      isLoadingWaitingAPIResponse = true;
    });

    var ctrl = context.read<UserController>();
    Map data = {
      'email': email.text,
      'appName': appName,
    };

    var response = await ctrl.updateUserPasswordVerifyEmail(data);
    await Future.delayed(Duration(seconds: 1));

    isVisible = false;
    setState(() {});

    userId = response.data?["data"]["userId"] ?? ''; // Here we take the UserId
    print('Je suis sencé venir mon ami josué : $userId');

    if (response.status) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyOtpForgotPasswordPage(userId: userId),
        ),
      );
      var msg = (response.data?['message'] ?? "");
      MessageWidgetsSuccess.showSnack(context, msg);

    } else {
      var msg = response.isException == true ? response.errorMsg : (response.data?['message']);
      MessageWidgets.showSnack(context, msg);
    }
    setState(() {
      isLoadingWaitingAPIResponse = false;
    });

  }

  void _handleSignUpPressed() async {
    if (isLoadingWaitingAPIResponse) return;

    setState(() {
      isLoadingWaitingAPIResponse = true;
      isCancelButtonVisible = true;
    });

    await VerifyEmailPressed();

    setState(() {
      isLoadingWaitingAPIResponse = false;
      isCancelButtonVisible = false;
    });
  }

  showSnackBar(context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(SnackBar(
      content: Text(message),
      action:
      SnackBarAction(label: 'OK',
          textColor: Colors.orange,
          onPressed: scaffold.hideCurrentSnackBar),
    ));
  }
}
