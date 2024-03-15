import 'package:flutter/material.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/pages/connexion/VerifyOtpLoginWithPhonePage.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/widgets/ChargementWidget.dart';
import 'package:mobile_fincopay/widgets/CustomVisibilityWidget.dart';
import 'package:mobile_fincopay/widgets/MessageWidgets.dart';
import 'package:mobile_fincopay/widgets/ReusableButtonWidgets.dart';
import 'package:provider/provider.dart';

class AccountFoundedPhoneToLoginPage extends StatefulWidget {
  final dynamic userInfo;

  const AccountFoundedPhoneToLoginPage({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<AccountFoundedPhoneToLoginPage> createState() => _AccountFoundedPhoneToLoginPageState();
}

class _AccountFoundedPhoneToLoginPageState extends State<AccountFoundedPhoneToLoginPage> {

  bool iSButtonPressedSignIn = false;
  bool isButtonPressedUseAnOtherAccount = false;
  bool isButtonPressedForgotpassword = false;

  var formKey = GlobalKey<FormState>();
  bool isVisible = false;
  bool isLoadingWaitingAPIResponse = false;

  var appname = "FINCOPAY";
  //CustomVisibility Bloc variable
  bool isCancelButtonVisible = false;
  String? userId; // Declare the userId variable here

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

                        child: Image.asset("assets/avatard.png")
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
                    '${widget.userInfo['phone'] == null ? "Phone : null" : widget.userInfo['phone']}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.052),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'By pressing Login button, you\'ll receive otp to your mobile phone number to verify to login.',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                ReusableButtonWidgets(
                  text: "Login",
                  fontSize: 14,
                  onPressed: isLoadingWaitingAPIResponse ? null : _handleRequestOTPtoLoginPressed,
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
                          Navigator.pushNamedAndRemoveUntil(context, Routes.LoginPageRoutes, ModalRoute.withName('/loginpage'),);
                        },
                        child: Text(
                          'Login With Email',
                          style: TextStyle(
                            fontSize: 14,
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

  Future<void> RequestOTPtoLogin() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!formKey.currentState!.validate()) {
      return;
    }

    isVisible = true;
    setState(() {
      isLoadingWaitingAPIResponse = true;
    });

    var phone = widget.userInfo['phone'];
    var ctrl = context.read<UserController>();
    Map data = {
      "phone":phone, //The phone number is complete it's means : with Country Code ************************************
      "appName":appname
    };

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
          builder: (context) => VerifyOtpLoginWithPhonePage(userId: userId),
        ),
      );
      var msg = (response.data?['message'] ?? "Enter the OPT sent to phone number");
      MessageWidgetsSuccess.showSnack(context, msg);

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
}
