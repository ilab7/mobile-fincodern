import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_fincopay/widgets/ReusableButtonWidgets.dart';

class VerifyOTP extends StatefulWidget {
  final String buttonText;
  final String routeName;
  final VoidCallback? onPressed;
  final VoidCallback? onBackButtonPressed;
  final void Function(List<TextEditingController>) updateVariableCallback;

  VerifyOTP({required this.buttonText,
    required this.routeName,
    this.onPressed,
    this.onBackButtonPressed,
    required this.updateVariableCallback,
  });
  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  late List<TextEditingController> _controllers;
  late String otpValue;

  void updateVariable() {
    widget.updateVariableCallback(_controllers);
  }

  late int _numberOfDigits;

  var formKey = GlobalKey<FormState>();
  bool isVisible = false; // A flag to control the visibility of a loading widget
  bool isLoadingWaitingAPIResponse = false; // A flag to indicate if an API request is in progress

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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.14),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: widget.onBackButtonPressed,
                            /*onTap: (){
                              Navigator.pushNamedAndRemoveUntil(context, Routes.LoginPageRoutes, ModalRoute.withName('/discoverpage'),);
                            },*/
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.135),
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
                              fontWeight: FontWeight.w700,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        _numberOfDigits,
                            (index) => buildDigitTextField(index),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    ReusableButtonWidgets(
                      text: widget.buttonText,
                      fontSize: 14,
                      onPressed: widget.onPressed,
                      color: Color(0xFF336699),
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
}