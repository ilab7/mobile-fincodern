import 'package:flutter/material.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/pages/connexion/AccountFoundedEmailToLoginPage.dart';
import 'package:mobile_fincopay/pages/connexion/AccountFoundedPhoneToLoginPage.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/widgets/ChargementWidget.dart';
import 'package:mobile_fincopay/widgets/CustomVisibilityWidget.dart';
import 'package:mobile_fincopay/widgets/EntryFieldEmailWithValidateWidgets.dart';
import 'package:mobile_fincopay/widgets/EntryFieldMobileNumberWithValidateWidgets.dart';
import 'package:mobile_fincopay/widgets/MessageWidgets.dart';
import 'package:mobile_fincopay/widgets/ReusableButtonWidgets.dart';
import 'package:provider/provider.dart';

class FindYourAccountPage extends StatefulWidget {
  @override
  State<FindYourAccountPage> createState() => _FindYourAccountPageState();
}

class _FindYourAccountPageState extends State<FindYourAccountPage> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userCtrl = context.read<UserController>();
      userCtrl.getDataAPI();
    });
  }

  bool iSButtonPressedSearch = false;
  //bool isButtonPressedLoginwithphonenumberoremailaddress = false;
  bool isButtonPressedSkipfornow = false;
  var mobileNumberoremailaddress = TextEditingController();
  bool isVisible = false;
  var formKey = GlobalKey<FormState>();
  bool isLoadingWaitingAPIResponse = false;

  //CustomVisibility Bloc variable
  bool isCancelButtonVisible = false;

  var mobilephonenumber = TextEditingController();
  var emailWithValidate = TextEditingController();
  bool isEmailFilled = false;
  bool isPhoneFilled = false;

  var response;
  var appname = "FINCOPAY";

  var userInfo; //UserInfo variable to store API response User info

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
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.all(06.0),
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.14),
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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.12),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Find your account',
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
                          'Please enter your email address or phone number to search your account',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      EntryFieldMobileNumberWithValidateWidgets(
                        onChanged: (value) {
                          setState(() {
                            isPhoneFilled = !mobilephonenumber.text.isEmpty;
                            //isPhoneFilled = value.isNotEmpty;
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
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      ReusableButtonWidgets(
                        text: "Search",
                        fontSize: 14,
                        onPressed: isLoadingWaitingAPIResponse ? null : _handleFindYourAccountPressed,
                        color: Color(0xFF336699),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
                                    isButtonPressedSkipfornow = !isButtonPressedSkipfornow;
                                  });
                                },
                                child: Text(
                                  'Skip for now',
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
        ],
      ),
    );
  }

  Future<void> FindYourAccountWithEmailPressed() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!formKey.currentState!.validate()) {
      return;
    }

    isVisible = true;
    setState(() {
      isLoadingWaitingAPIResponse = true;
    });

    if (emailWithValidate.text.isNotEmpty){
      var ctrl = context.read<UserController>();
      String phoneNumberOrEmailAddress = mobileNumberoremailaddress.text;
      //print(phoneNumberOrEmailAddress); // Output
      Map data = {
        "email": phoneNumberOrEmailAddress,
        "appName": appname,
      };
      response = await ctrl.findAccountEmail(data);
      await Future.delayed(Duration(seconds: 1));
    } else if (mobilephonenumber.text.isNotEmpty) {
      String phoneNumberOrEmailAddress = mobileNumberoremailaddress.text; //We do it tho evoid to long string
      //print(phoneNumberOrEmailAddress); // Output
      var ctrl = context.read<UserController>();
      Map data = {
        "phone": phoneNumberOrEmailAddress,
        "appName": appname,
      };
      response = await ctrl.findAccountPhone(data);
      await Future.delayed(Duration(seconds: 1));
    }

    isVisible = false;
    setState(() {});

    userInfo = response.data?["data"]; //UserInfo response

    if (response.status) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
      //If response.date contains email and phone, then, show field of
      if(response.data?["data"] != null && response.data?["data"].containsKey("email")){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccountFoundedEmailToLoginPage(userInfo: userInfo),
          ),
        );
      } else if (response.data?["data"] != null && response.data?["data"].containsKey("phone")){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AccountFoundedPhoneToLoginPage(userInfo: userInfo),
          ),
        );
      } else if (response.data?.containsKey("message")){
        //Navigator.popAndPushNamed(context, Routes.PasswordChangedPageRoutes);
        var msg = "No account linked to this email";
        MessageWidgetsSuccess.showSnack(context, msg);
      }else {
        var msg = response.isException == true ? response.errorMsg : (response.data?['message']);
        MessageWidgets.showSnack(context, msg);
      }
      setState(() {
        isLoadingWaitingAPIResponse = false;
      });
    }
  }

  void _handleFindYourAccountPressed() async {
    if (isLoadingWaitingAPIResponse) return;

    setState(() {
      isLoadingWaitingAPIResponse = true;
      isCancelButtonVisible = true;
    });

    if (!isPhoneFilled && !isEmailFilled) {
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
      await FindYourAccountWithEmailPressed();
    }

    setState(() {
      isLoadingWaitingAPIResponse = false;
      isCancelButtonVisible = false;
    });
  }

  bool validateFields() {
    if(emailWithValidate.text.isEmpty && mobilephonenumber.text.isEmpty) {
      return false;
    }

    return true;
  }
}
