import 'package:flutter/material.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/pages/connexion/RequestOtpLoginWithPhonePage.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/widgets/ChargementWidget.dart';
import 'package:mobile_fincopay/widgets/CustomVisibilityWidget.dart';
import 'package:mobile_fincopay/widgets/EntryFieldMobileNumberWidgets.dart';
import 'package:mobile_fincopay/widgets/MessageWidgets.dart';
import 'package:mobile_fincopay/widgets/ReusableButtonWidgets.dart';
import 'package:provider/provider.dart';

class LoginWithPhoneNumberRequestOTPPage extends StatefulWidget {
  @override
  State<LoginWithPhoneNumberRequestOTPPage> createState() => _LoginWithPhoneNumberRequestOTPPageState();
}

class _LoginWithPhoneNumberRequestOTPPageState extends State<LoginWithPhoneNumberRequestOTPPage> {
  bool iSButtonPressedSignIn = false;
  bool isButtonPressedRequestOTPtoLogin = false;
  bool isButtonPressedBacktologin = false;

  var phone = TextEditingController();
  String appName = 'FINCOPAY';

  var formKey = GlobalKey<FormState>();
  bool isVisible = false;
  bool isLoadingWaitingAPIResponse = false;

  //CustomVisibility Bloc variable
  bool isCancelButtonVisible = false;

  List<TextEditingController> otpValue = [];
  String? userId; // Declare the userId variable here

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
                      ctrl: phone,
                      label: "Mobile Number",
                      required: true,
                      isMobileNumber: false,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    ReusableButtonWidgets(
                      text: "Request OTP to login",
                      fontSize: 14,
                      onPressed: isLoadingWaitingAPIResponse ? null :_handleRequestOTPtoLoginPressed,
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
      "phone":phone.text, //The phone number is complete it's means : with Country Code ************************************
      "appName":appName
    };

    print("DATA TO SEND JOSUE API TEST : ${phone.text}");
    print("DATA TO SEND JOSUE API TEST : $appName");

    var response = await ctrl.requestOTPPhoneNumber(data);
    await Future.delayed(Duration(seconds: 10));

    isVisible = false;
    setState(() {});

    userId = response.data?["data"]["userId"] ?? ''; // Here we take the UserId
    print("USERID CHECKING  : $userId");


    if (response.status) {
      await Future.delayed(Duration(seconds: 12));
      setState(() {});
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RequestOtpLoginWithPhonePage(userId: userId, phone: phone.text,),
        ),
      );

    } else {
      var msg = response.isException == true ? response.errorMsg : (response.data?['message']);
      MessageWidgets.showSnack(context, msg);
    }
    setState(() {
      isLoadingWaitingAPIResponse = false;
    });

  }

  void _handleRequestOTPtoLoginPressed() async {
    if(isLoadingWaitingAPIResponse) return;

    setState(() {
      isLoadingWaitingAPIResponse = true;
      isCancelButtonVisible = true;
    });

    await RequestOTPtoLogin();

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
