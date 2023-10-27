import 'package:flutter/material.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/widgets/ChargementWidget.dart';
import 'package:mobile_fincopay/widgets/EntryFieldEmailWidgets.dart';
import 'package:mobile_fincopay/widgets/EntryFieldMobileNumberWidgets.dart';
import 'package:mobile_fincopay/widgets/EntryfieldConfirmWidgets.dart';
import 'package:mobile_fincopay/widgets/MessageWidgets.dart';
import 'package:mobile_fincopay/widgets/PasswordWithCriteriatWidgets.dart';
import 'package:mobile_fincopay/widgets/ReusableButtonWidgets.dart';
import 'package:mobile_fincopay/widgets/ReusableEntryFieldWidgets.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool iSButtonPressedSignIn = false;
  bool isButtonPressedSkipfornow = false;
  bool isButtonPressedLogin = false;
  var email = TextEditingController();
  var password = TextEditingController();
  var confirm = TextEditingController();
  var phone = TextEditingController();
  var fullname = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isVisible = false;
  bool isLoadingWaitingAPIResponse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _body(context),
          ChargementWidget(isVisible)
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Form(
      key: formKey,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(06.0),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
                                //color: Colors.black,
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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Have you already an account? ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(context, Routes.LoginPageRoutes);
                                setState(() {
                                  isButtonPressedLogin = !isButtonPressedLogin;
                                });
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: isButtonPressedSkipfornow ?  Colors.orange : Color(0xFF336699),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      ReusableEntryFieldWidgets(
                        ctrl: fullname,
                        label: "Full name",
                        required: true,
                        isName: false,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      EntryFieldEmailWidgets(
                        ctrl: email,
                        required: true,
                        label: "Email",
                        isEmail: false,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      EntryFieldMobileNumberWidgets(
                        ctrl: phone,
                        label: "Phone",
                        required: true,
                        isMobileNumber: false,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      PasswordWithCriteriatWidgets(
                        ctrl: password,
                        label: "Password",
                        required: true,
                        isPassword: false,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Align(alignment: Alignment.centerLeft, child: Text("Minimum 8 characters", style: TextStyle(fontSize: 11))),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      EntryFieldConfirmWidgets(
                        ctrl: confirm,
                        password: password,
                        label: "Confirm",
                        required: true,
                        isConfirm: false,
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                      ReusableButtonWidgets(
                        text: "Sign Up",
                        fontSize: 14,
                        onPressed: isLoadingWaitingAPIResponse ? null :_handleSignUpPressed,
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

  Future<void> SignUpPressed() async {
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
      'fullname': fullname.text,
      'email': email.text,
      'phone': phone.text,
      'password': password.text,
      'confirm': confirm.text,
    };
    print("VALUE OF ${password}");
    print("Data to send to create an account $data");
    var response = await ctrl.register(data);
    await Future.delayed(Duration(seconds: 1));

    isVisible = false;
    setState(() {});
    print("The Status response after resgistered ${response.status}");
    Navigator.pushReplacementNamed(context, Routes.LoginPageRoutes);
    if (response.status) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
      Navigator.pushReplacementNamed(context, Routes.LoginPageRoutes);
    } else {
      var msg = response.isException == true ? response.errorMsg : (response.data?['message']);
      MessageWidgets.showSnack(context, msg);
    }
    setState(() {
      isLoadingWaitingAPIResponse = false;
    });
  }

  void _handleSignUpPressed() async {
    if(isLoadingWaitingAPIResponse) return;
    setState(() {
      isLoadingWaitingAPIResponse = true;
    });

    await SignUpPressed();

    setState(() {
      isLoadingWaitingAPIResponse = false;
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
