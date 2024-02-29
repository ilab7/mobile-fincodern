import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/widgets/MessageWidgets.dart';
import 'package:mobile_fincopay/widgets/ReusableButtonWidgets.dart';

class RequestOtpLoginWithPhonePage extends StatefulWidget {
  final String? userId;
  final String? phone;

  const RequestOtpLoginWithPhonePage({Key? key, required this.userId, required this.phone}) : super(key: key);

  @override
  _RequestOtpLoginWithPhonePageState createState() => _RequestOtpLoginWithPhonePageState();
}

class _RequestOtpLoginWithPhonePageState extends State<RequestOtpLoginWithPhonePage> {
  String? get userId => widget.userId;
  String? get phone => widget.phone;
  var IdUser;

  String appName = 'FINCOPAY';

  late List<TextEditingController> _controllers;
  late String otpValue;

  String? userIdd; // Declare the userId variable here

  late int _numberOfDigits;

  var formKey = GlobalKey<FormState>();
  bool isVisible = false; // A flag to control the visibility of a loading widget
  bool isLoadingWaitingAPIResponse = false; // A flag to indicate if an API request is in progress
  bool isLoadingWaitingAPIResponseOther = false; // A flag to indicate if an API request is in progress

  @override
  void initState() {
    super.initState();
    _numberOfDigits = 6;
    _controllers = List.generate(_numberOfDigits, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(09.0),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context, Routes.SignUpPagePageRoutes);
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.14),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Enter your OTP',
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
                        'Please enter the OTP sent to your email address or mobile phone number',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Form(
                      key: formKey, // Assign the globalKey to the Form widget
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          _numberOfDigits,
                              (index) => buildDigitTextField(index),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    ReusableButtonWidgets(
                      text: 'Verify Otp',
                      fontSize: 14,
                      onPressed: isLoadingWaitingAPIResponse ? null : _handleVerifyOtpPressed,
                      color: Color(0xFF336699),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    TextButton(
                      onPressed: isLoadingWaitingAPIResponse ? null : _handleRequestAgainOTPtoLoginPressed,
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(horizontal: 16.0),
                        ),
                        alignment: Alignment.centerRight,
                        textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Resend otp',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDigitTextField(int index) {
    return SizedBox(
      width: 40,
      height: 40,
      child: TextFormField(
        controller: _controllers[index],
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty && index < _numberOfDigits - 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        autofocus: index == 0,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          counterText: '',
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orange),
          ),
        ),
      ),
    );
  }

  Future<void> VerifyOtpPressed() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!formKey.currentState!.validate()) {
      return;
    }

    isVisible = true;
    setState(() {
      isLoadingWaitingAPIResponse = true;
    });

    // Retrieve the OTP value from the controllers
    otpValue = '';
    for (var controller in _controllers) {
      otpValue += controller.text;
    }

    IdUser = userId;

    var ctrl = context.read<UserController>();
    Map<String, dynamic> data = {
      'userId': IdUser, // Introduce the userId value here
      'otp': otpValue, // Add the OTP value to the data map
    };

    var res = await ctrl.requestOTPPhoneNumber(data);
    await Future.delayed(Duration(seconds: 1));

    isVisible = false;
    setState(() {});

    print("ELEMENTS TO SEND AS OTP : $IdUser");
    print("ELEMENTS TO SEND AS OTP : $otpValue");

    if (res.status) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {});

      Navigator.pushNamedAndRemoveUntil(context, Routes.BottomNavigationPageRoutes, ModalRoute.withName('/discoverpage'),);

    } else {
      var msg = res.isException == true ? res.errorMsg : (res.data?['message']);
      MessageWidgets.showSnack(context, msg);
    }
    setState(() {
      isLoadingWaitingAPIResponse = false;
    });
  }

  void _handleVerifyOtpPressed() async {
    if(isLoadingWaitingAPIResponse) return;

    setState(() {
      isLoadingWaitingAPIResponse = true;
    });

    await VerifyOtpPressed();

    setState(() {
      isLoadingWaitingAPIResponse = false;
    });
  }

  Future<void> RequestAgainOTPtoLogin() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!formKey.currentState!.validate()) {
      return;
    }

    isVisible = true;
    setState(() {
      isLoadingWaitingAPIResponseOther = true;
    });

    var ctrl = context.read<UserController>();
    Map data = {
      "phone": phone,
      "appName": appName
    };

    var response = await ctrl.ResendOTPForLoginWithPhoneNumber(data);//Change Function Resend
    await Future.delayed(Duration(seconds: 1));

    isVisible = false;
    setState(() {});

    print("DATA TO SEND JOSUE API TEST : ${phone}");
    print("DATA TO SEND JOSUE API TEST : $appName");

    userIdd = response.data?["data"]["userId"] ?? ''; // Here we update the userId value

    if (response.status) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {});

      IdUser = userIdd; //Here we are updating the IdUser variable to userIdd
      // We are passing by IdUser variable because we can not modified a setter (userId with is Final)
      print("THIS IS VALUE OF IdUser : ${IdUser}");

    } else {
      var msg = response.isException == true ? response.errorMsg : (response.data?['message']);
      MessageWidgets.showSnack(context, msg);
    }
    setState(() {
      isLoadingWaitingAPIResponseOther = false;
    });

  }

  void _handleRequestAgainOTPtoLoginPressed() async {
    if(isLoadingWaitingAPIResponseOther) return;

    setState(() {
      isLoadingWaitingAPIResponseOther = true;
    });

    await RequestAgainOTPtoLogin();

    setState(() {
      isLoadingWaitingAPIResponseOther = false;
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