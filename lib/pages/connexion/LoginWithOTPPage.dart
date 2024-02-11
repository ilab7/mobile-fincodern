import 'package:flutter/material.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/pages/connexion/VerifyOTP.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/widgets/ChargementWidget.dart';
import 'package:mobile_fincopay/widgets/EntryFieldMobileNumberWidgets.dart';
import 'package:mobile_fincopay/widgets/MessageWidgets.dart';
import 'package:mobile_fincopay/widgets/ReusableButtonWidgets.dart';
import 'package:provider/provider.dart';

class LoginWithOTPPage extends StatefulWidget {
  @override
  State<LoginWithOTPPage> createState() => _LoginWithOTPPageState();
}

class _LoginWithOTPPageState extends State<LoginWithOTPPage> {
  bool iSButtonPressedSignIn = false;
  bool isButtonPressedRequestOTPtoLogin = false;
  bool isButtonPressedBacktologin = false;
  var mobileNumber = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isVisible = false;
  bool isLoadingWaitingAPIResponse = false;

  List<TextEditingController> otpValue = [];

  void updateVariableCallback(List<TextEditingController> controllers) {
    otpValue = controllers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              _body(context),
              ChargementWidget(isVisible),
            ],
          ),
        ),
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.13), // espace en haut
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
                              //color: Colors.black,
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Login with OTP',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                    EntryFieldMobileNumberWidgets(
                      ctrl: mobileNumber,
                      label: "Mobile Number",
                      required: true,
                      isMobileNumber: false,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    ReusableButtonWidgets(
                      text: "Request OTP to login",
                      fontSize: 14,
                      onPressed: isLoadingWaitingAPIResponse ? null :_handleSignUpPressed,
                      color: Color(0xFF336699),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(context, Routes.LoginPageRoutes, ModalRoute.withName('/discoverpage'),);
                              },
                              child: Text(
                                'Back to login',
                                style: TextStyle(
                                  fontSize: 14,
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
      ),
    );
  }

  Future<void> RequestOTPtoLogin() async {
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
      'mobile': mobileNumber.text,
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
          buttonText: 'Login',
          updateVariableCallback: updateVariableCallback,
          routeName: Routes.BottomNavigationPageRoutes,
          onPressed: () {
            //Navigator.popAndPushNamed(context, Routes.BottomNavigationPageRoutes);
            Navigator.pushNamedAndRemoveUntil(context, Routes.BottomNavigationPageRoutes, ModalRoute.withName('/discoverpage'),);
          },
          onBackButtonPressed: () {
            //Navigator.pop(context, Routes.LoginWithOTPPageRoutes);
            Navigator.pushNamedAndRemoveUntil(context, Routes.LoginPageRoutes, ModalRoute.withName('/discoverpage'),);
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
            buttonText: 'Login',
            updateVariableCallback: updateVariableCallback,
            routeName: Routes.BottomNavigationPageRoutes,
            onPressed: () {
              //Navigator.popAndPushNamed(context, Routes.BottomNavigationPageRoutes);
              Navigator.pushNamedAndRemoveUntil(context, Routes.BottomNavigationPageRoutes, ModalRoute.withName('/discoverpage'),);
            },
            onBackButtonPressed: () {
              //Navigator.pop(context, Routes.LoginWithOTPPageRoutes);
              Navigator.pushNamedAndRemoveUntil(context, Routes.LoginPageRoutes, ModalRoute.withName('/discoverpage'),);
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

  void _handleSignUpPressed() async {
    if (isLoadingWaitingAPIResponse) return;
    setState(() {
      isLoadingWaitingAPIResponse = true;
    });

    await RequestOTPtoLogin();

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
