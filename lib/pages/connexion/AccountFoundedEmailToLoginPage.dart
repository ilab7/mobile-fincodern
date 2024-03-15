import 'package:flutter/material.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/widgets/ChargementWidget.dart';
import 'package:mobile_fincopay/widgets/CustomVisibilityWidget.dart';
import 'package:mobile_fincopay/widgets/EntryFieldPasswordWidgets.dart';
import 'package:mobile_fincopay/widgets/MessageWidgets.dart';
import 'package:mobile_fincopay/widgets/ReusableButtonWidgets.dart';
import 'package:provider/provider.dart';

class AccountFoundedEmailToLoginPage extends StatefulWidget {
  final dynamic userInfo;

  const AccountFoundedEmailToLoginPage({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<AccountFoundedEmailToLoginPage> createState() => _AccountFoundedEmailToLoginPageState();
}

class _AccountFoundedEmailToLoginPageState extends State<AccountFoundedEmailToLoginPage> {
  bool iSButtonPressedSignIn = false;
  bool isButtonPressedUseAnOtherAccount = false;
  bool isButtonPressedForgotpassword = false;
  var email = TextEditingController();
  var password = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isVisible = false;
  bool isLoadingWaitingAPIResponse = false;

  var appname = "FINCOPAY";
  //CustomVisibility Bloc variable
  bool isCancelButtonVisible = false;

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
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(06.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.11),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Container(
                  height: 170,
                  padding: EdgeInsets.symmetric(horizontal: 0.0),
                  child: Center(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(70),

                        child: Image.asset("assets/avatard.png"),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    //'Josué Nlandu',
                    '${widget.userInfo['fullName'] == null ? "Fullname : null" : widget.userInfo['fullName']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '${widget.userInfo['email'] == null ? "Email : null" : widget.userInfo['email']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                SizedBox(height: 16),
                EntryFieldPasswordWidgets(
                  ctrl: password,
                  label: "Enter your Password",
                  required: true,
                  isPassword: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, Routes.ForgotYourPasswordPageRoutes);
                      setState(() {
                        isButtonPressedForgotpassword = !isButtonPressedForgotpassword;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                ReusableButtonWidgets(
                  text: "Login",
                  fontSize: 14,
                  onPressed: isLoadingWaitingAPIResponse ? null : _handleLoginPressed,
                  color: Color(0xFF336699),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.023),
                //Bloc of Login with Google or Facebook
                /*Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1.0,
                        width: 75,
                        color: Colors.grey,
                      ),
                      SizedBox(width: 11,),
                      Text(
                        'Or login with',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 11,),
                      Container(
                        height: 1.0,
                        width: 75,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.023),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {

                          });
                        },
                        child: Image.asset(
                          "assets/facebook.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.height * 0.04),
                      InkWell(
                        onTap: () {
                          setState(() {

                          });
                        },
                        child: Image.asset(
                          "assets/google.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ],
                  ),
                ),*/

                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.LoginWithPhoneNumberRequestOTPPageRoutes);
                        },
                        child: Text(
                          'Login With Phone number',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF336699),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, Routes.LoginPageRoutes);
                            setState(() {
                              isButtonPressedUseAnOtherAccount = !isButtonPressedUseAnOtherAccount;
                            });
                          },
                          child: Text(
                            'Use an other account',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> LoginPressed() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!formKey.currentState!.validate()) {
      return;
    }

    isVisible = true;
    setState(() {
      isLoadingWaitingAPIResponse = true;
    });

    var email = widget.userInfo['email'];
    var ctrl = context.read<UserController>();
    Map data = {
      "email": email,
      "password": password.text,
      "appName": appname,
    };

    var response = await ctrl.login(data);
    await Future.delayed(Duration(seconds: 1));

    isVisible = false;
    setState(() {});

    if (response.status) {
      await Future.delayed(Duration(seconds: 3));
      setState(() {});
      Navigator.pushNamedAndRemoveUntil(context, Routes.BottomNavigationPageRoutes, ModalRoute.withName('/loginpage'),);

      var msg = (response.data?['message'] ?? "You're login");
      MessageWidgetsSuccess.showSnack(context, msg);

    } else {
      var msg = response.isException == true ? response.errorMsg : (response.data?['message']);
      MessageWidgets.showSnack(context, msg);
    }
    setState(() {
      isLoadingWaitingAPIResponse = false;
    });
  }

  void _handleLoginPressed() async {
    if(isLoadingWaitingAPIResponse) return;
    setState(() {
      isLoadingWaitingAPIResponse = true;
      isCancelButtonVisible = true;
    });

    await LoginPressed();

    setState(() {
      isLoadingWaitingAPIResponse = false;
      isCancelButtonVisible = false;
    });
  }
}
