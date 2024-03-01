import 'package:flutter/material.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/widgets/ChargementWidget.dart';
import 'package:mobile_fincopay/widgets/CustomVisibilityWidget.dart';
import 'package:mobile_fincopay/widgets/EntryfieldConfirmWidgets.dart';
import 'package:mobile_fincopay/widgets/MessageWidgets.dart';
import 'package:mobile_fincopay/widgets/PasswordWithCriteriatWidgets.dart';
import 'package:mobile_fincopay/widgets/ReusableButtonWidgets.dart';
import 'package:provider/provider.dart';

class CreateNewPasswordPage extends StatefulWidget {
  @override
  State<CreateNewPasswordPage> createState() => _CreateNewPasswordPageState();
}

class _CreateNewPasswordPageState extends State<CreateNewPasswordPage> {
  bool isButtonPressedUpdatePassword = false;

  var newPassword = TextEditingController();
  var confirmPassword = TextEditingController();
  bool isLoadingWaitingAPIResponse = false;
  bool isVisible = false;

  //CustomVisibility Bloc variable
  bool isCancelButtonVisible = false;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _body(context),
          ChargementWidget(isVisible),
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.13),
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
                            'Create new password',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                    PasswordWithCriteriatWidgets(
                      ctrl: newPassword,
                      label: "New password",
                      required: true,
                      isPassword: false,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Align(alignment: Alignment.centerLeft, child: Text("Minimum 8 characters", style: TextStyle(fontSize: 11))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    EntryFieldConfirmWidgets(
                      ctrl: confirmPassword,
                      password: newPassword,
                      label: "Confirm new password",
                      required: true,
                      isConfirm: false,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                    ReusableButtonWidgets(
                      text: "Update password",
                      fontSize: 14,
                      onPressed: isLoadingWaitingAPIResponse ? null :_handleCreateNewPasswordPressed,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> CreateNewPasswordPressed() async {
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
      'newPassword': newPassword.text,
    };

    var response = await ctrl.updateUserPassword(data);
    await Future.delayed(Duration(seconds: 1));

    isVisible = false;
    setState(() {});
    print("The Status response after resgistered ${response.status}");
    Navigator.pushReplacementNamed(context, Routes.PasswordChangedPageRoutes);
    if (response.status) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
      Navigator.pushReplacementNamed(context, Routes.PasswordChangedPageRoutes);
    } else {
      var msg = response.isException == true ? response.errorMsg : (response.data?['message']);
      MessageWidgets.showSnack(context, msg);
    }
    setState(() {
      isLoadingWaitingAPIResponse = false;
    });
  }

  void _handleCreateNewPasswordPressed() async {
    if(isLoadingWaitingAPIResponse) return;
    setState(() {
      isLoadingWaitingAPIResponse = true;
      isCancelButtonVisible = true;
    });

    await CreateNewPasswordPressed();

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
