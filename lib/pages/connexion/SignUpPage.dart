import 'package:flutter/material.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/pages/connexion/VerifyOtpSignUpPage.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/widgets/ChargementWidget.dart';
import 'package:mobile_fincopay/widgets/CustomVisibilityWidget.dart';
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
  bool isButtonPressedLogin = false; // A flag to indicate if the login button is pressed

  String? userId; // Declare the userId variable here

  // All fields of register
  var email = TextEditingController();
  var password = TextEditingController();
  var confirm = TextEditingController();
  var phone = TextEditingController();
  var fullname = TextEditingController();
  String appName = 'FINCOPAY';

  //CustomVisibility Bloc variable
  bool isCancelButtonVisible = false;

  var formKey = GlobalKey<FormState>();
  bool isVisible = false; // A flag to control the visibility of a loading widget
  bool isLoadingWaitingAPIResponse = false; // A flag to indicate if an API request is in progress

  List<TextEditingController> otpValue = [];

  void updateVariableCallback(List<TextEditingController> controllers) {
    otpValue = controllers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _body(context),
          ChargementWidget(isVisible) // A loading widget that is shown when isVisible is true
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
                                Navigator.pushNamedAndRemoveUntil(context, Routes.LoginPageRoutes, ModalRoute.withName('/discoverpage'),);
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
                                fontWeight: FontWeight.w700,
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
                                Navigator.pushNamedAndRemoveUntil(context, Routes.LoginPageRoutes, ModalRoute.withName('/discoverpage'),);
                                setState(() {
                                  isButtonPressedLogin = !isButtonPressedLogin;
                                });
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF336699),
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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.005),
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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
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

    //Function to extract the contry code from the phone number
    String extractFirstFourLetters(String input) {
      if (input.length >= 5) {
        return input.substring(0, 5);
      } else {
        return input;
      }
    }
    String countryCode = extractFirstFourLetters(phone.text);

    var ctrl = context.read<UserController>();
    Map data = {
      'fullName': fullname.text,
      'email': email.text,
      'phone': phone.text,
      'countryCode': countryCode,
      'password': password.text,
      'confirmPassword': confirm.text,
      'appName': appName,
      //'roles':'user',
    };

    var response = await ctrl.register(data);
    await Future.delayed(Duration(seconds: 1));

    isVisible = false;
    setState(() {});

    userId = response.data?["data"]["userId"] ?? ''; // Here we take the UserId

    if (response.status) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyOtpSignUpPage(userId: userId),
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

    await SignUpPressed();

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
