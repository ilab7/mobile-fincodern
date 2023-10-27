import 'package:fincodern/controllers/UserController.dart';
import 'package:fincodern/pages/connexion/VerifyOTP.dart';
import 'package:fincodern/utils/Routes.dart';
import 'package:fincodern/widgets/ChargementWidget.dart';
import 'package:fincodern/widgets/EntryFieldEmailWithValidateWidgets.dart';
import 'package:fincodern/widgets/EntryFieldMobileNumberWithValidateWidgets.dart';
import 'package:fincodern/widgets/MessageWidgets.dart';
import 'package:fincodern/widgets/ReusableButtonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotYourPassword extends StatefulWidget {
  @override
  State<ForgotYourPassword> createState() => _ForgotYourPasswordState();
}

class _ForgotYourPasswordState extends State<ForgotYourPassword> {
  bool iSButtonPressedSendaCode = false;
  bool Backtologin = false;

  var mobileNumberoremailaddress = TextEditingController();
  var mobilephonenumber = TextEditingController();
  var emailWithValidate = TextEditingController();

  bool isEmailFilled = false;
  bool isPhoneFilled = false;
  bool isLoadingWaitingAPIResponse = false;

  bool isVisible = false;
  var formKey = GlobalKey<FormState>();

  List<TextEditingController> otpValue = [];

  void updateVariableCallback(List<TextEditingController> controllers) {
    otpValue = controllers;
  }

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
                            Navigator.pushReplacementNamed(context, Routes.LoginPageRoutes);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                          ),
                        ),
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Select which are should we use to reset your password',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),

                  EntryFieldMobileNumberWithValidateWidgets(
                    onChanged: (value) {
                      setState(() {
                        isPhoneFilled = value.isNotEmpty;
                        isEmailFilled = false;
                        mobileNumberoremailaddress.text = value; // Store the value in mobileNumberoremailaddress
                      });
                    },
                    readOnly: isEmailFilled,
                    suffixIcon: isPhoneFilled ? Container(height: 5, padding: EdgeInsets.all(5.0), child : Image.asset("assets/accept.png")) : null,
                    ctrl: mobilephonenumber,
                    label: "",
                    required: true,
                    isMobileNumberWithValidate: false,
                  ),

                  EntryFieldEmailWithValidateWidgets(
                    onChanged: (value) {
                      setState(() {
                        isEmailFilled = value.isNotEmpty;
                        isPhoneFilled = false;
                        mobileNumberoremailaddress.text = value; // Store the value in mobileNumberoremailaddress
                      });
                    },
                    readOnly: isPhoneFilled,
                    suffixIcon: isEmailFilled ? Container(height: 5, padding: EdgeInsets.all(5.0), child : Image.asset("assets/accept.png")) : null,
                    ctrl: emailWithValidate,
                    label: "",
                    required: true,
                    isEmailWithValidate: false,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  ReusableButtonWidgets(
                    text: "Send a code",
                    fontSize: 14,
                    onPressed: isLoadingWaitingAPIResponse ? null : _handleLoginPressed,
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
                              Navigator.pushReplacementNamed(context, Routes.LoginPageRoutes);
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

  Future<void> SendACodePressed() async {
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
      "mobileNumberoremailaddress": mobileNumberoremailaddress.text,
    };

    var response = await ctrl.SendOTPRequest(data);
    await Future.delayed(Duration(seconds: 1));

    isVisible = false;
    setState(() {});
    print(response.status);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => VerifyOTP(
          buttonText: 'Submit',
          updateVariableCallback: updateVariableCallback,
          routeName: Routes.CreateNewPasswordPageRoutes,
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.CreateNewPasswordPageRoutes);
          },
          onBackButtonPressed: () {
            Navigator.pushReplacementNamed(context, Routes.ForgotYourPasswordPageRoutes);
          },
        ),
      ),
    ); //To delete after api connexion
    if (response.status) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyOTP(
            buttonText: 'Submit',
            updateVariableCallback: updateVariableCallback,
            routeName: Routes.CreateNewPasswordPageRoutes,
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.CreateNewPasswordPageRoutes);
            },
            onBackButtonPressed: () {
              Navigator.pushReplacementNamed(context, Routes.ForgotYourPasswordPageRoutes);
            },
          ),
        ),
      );
    } else {
      var msg =
      response.isException == true ? response.errorMsg : (response.data?['message']);
      MessageWidgets.showSnack(context, msg);
    }
    setState(() {
      isLoadingWaitingAPIResponse = false;
    });
  }

  void _handleLoginPressed() async {
    if (isLoadingWaitingAPIResponse) return;
    setState(() {
      isLoadingWaitingAPIResponse = true;
    });

    if (!validateFields()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("You must choose either to use your phone number or your email address!"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      await SendACodePressed();
    }

    setState(() {
      isLoadingWaitingAPIResponse = false;
    });
  }

  bool validateFields() {
    if(emailWithValidate.text.isEmpty && mobilephonenumber.text.isEmpty) {
      return false;
    }

    return true;
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
