import 'package:fincodern/controllers/UserController.dart';
import 'package:fincodern/utils/Routes.dart';
import 'package:fincodern/widgets/ChargementWidget.dart';
import 'package:fincodern/widgets/EntryFieldPasswordWidgets.dart';
import 'package:fincodern/widgets/MessageWidgets.dart';
import 'package:fincodern/widgets/ReusableButtonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountFoundedPage extends StatefulWidget {
  @override
  State<AccountFoundedPage> createState() => _AccountFoundedPageState();
}

class _AccountFoundedPageState extends State<AccountFoundedPage> {
  bool iSButtonPressedSignIn = false;
  bool isButtonPressedUseAnOtherAccount = false;
  bool isButtonPressedForgotpassword = false;
  var email = TextEditingController();
  var password = TextEditingController();

  var formKey = GlobalKey<FormState>();
  bool isVisible = false;
  bool isLoadingWaitingAPIResponse = false;

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
                              Navigator.pushReplacementNamed(context, Routes.LoginPageRoutes);
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
                        child: Image.asset("assets/josuenlandu.jpg")
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Josué Nlandu',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
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

                Container(
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
                              fontSize: 16,
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

    var ctrl = context.read<UserController>();
    Map data = {
      "password": password.text
    };

    var response = await ctrl.login(data);
    await Future.delayed(Duration(seconds: 1));

    isVisible = false;
    setState(() {});
    print(response.status);
    Navigator.popAndPushNamed(context, Routes.BottomNavigationPageRoutes); //To delete after api connexion
    if (response.status) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
      Navigator.pushReplacementNamed(context, Routes.BottomNavigationPageRoutes);
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
    if(isLoadingWaitingAPIResponse) return;
    setState(() {
      isLoadingWaitingAPIResponse = true;
    });

    await LoginPressed();

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
