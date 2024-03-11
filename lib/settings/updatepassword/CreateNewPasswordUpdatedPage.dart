import 'package:flutter/material.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/widgets/ChargementWidget.dart';
import 'package:mobile_fincopay/widgets/CustomVisibilityWidget.dart';
import 'package:mobile_fincopay/widgets/EntryFieldPasswordWidgets.dart';
import 'package:mobile_fincopay/widgets/EntryfieldConfirmWidgets.dart';
import 'package:mobile_fincopay/widgets/MessageWidgets.dart';
import 'package:mobile_fincopay/widgets/PasswordWithCriteriatWidgets.dart';
import 'package:mobile_fincopay/widgets/ReusableButtonWidgets.dart';
import 'package:provider/provider.dart';

class CreateNewPasswordUpdatedPage extends StatefulWidget {
  @override
  State<CreateNewPasswordUpdatedPage> createState() => _CreateNewPasswordUpdatedPageState();
}

class _CreateNewPasswordUpdatedPageState extends State<CreateNewPasswordUpdatedPage> {
  bool isButtonPressedUpdatePassword = false;

  var newPassword = TextEditingController();
  var currentPassword = TextEditingController();
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
                              Navigator.pushReplacementNamed(context, Routes.UpdatePasswordPageRoutes);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              //color: Colors.black,
                            ),
                          ),
                          Container(
                            height: 70,
                            child: Image.asset(
                              'assets/logo_fincopay.png',
                              width: 300,
                              height: 300,
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
                            'Update password',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    EntryFieldPasswordWidgets(
                      ctrl: currentPassword,
                      label: "Current password",
                      required: true,
                      isPassword: false,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                      onPressed: isLoadingWaitingAPIResponse ? null :_handleUpadatePasswordPressed,
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> UpdatePasswordPressed() async {
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
      "current password": newPassword.text,
      "new password": currentPassword.text,
    };

    var response = await ctrl.updateUserPasswordVerifyEmail(data);
    await Future.delayed(Duration(seconds: 1));

    isVisible = false;
    setState(() {});

    //Navigator.pushNamedAndRemoveUntil(context, Routes.SettingsPageRoutes, ModalRoute.withName('/settingspage'),); //To remove after
    Navigator.pushReplacementNamed(context, Routes.UpdatePasswordPageRoutes); //To remove after
    if (response.status) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
      Navigator.pushNamedAndRemoveUntil(context, Routes.SettingsPageRoutes, ModalRoute.withName('/settingspage'),);
    } else {
      var msg = response.isException == true ? response.errorMsg : (response.data?['message']);
      MessageWidgets.showSnack(context, msg);
    }
    setState(() {
      isLoadingWaitingAPIResponse = false;
    });
  }

  void _handleUpadatePasswordPressed() async {
    if(isLoadingWaitingAPIResponse) return;
    setState(() {
      isLoadingWaitingAPIResponse = true;
      isCancelButtonVisible = true;
    });

    await UpdatePasswordPressed();

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
