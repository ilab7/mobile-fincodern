import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool isCancelButtonPressed = false;
  bool isConfirmButtonPressed = false;
  bool isLogOutButtonPressed = false;
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pushReplacementNamed(context, Routes.BottomNavigationPageRoutes);
          },
        ),
        title: Text(
          'Profil',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Color(0xFF040034),
       /* actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Icon(Icons.menu),
          )
        ],*/
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Stack(
                            children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset("assets/josuenlandu.jpg"),
                                ),
                              ),
                              Positioned(
                                bottom: -13,
                                left: MediaQuery.of(context).size.width * 0.0,
                                right: MediaQuery.of(context).size.width * 0.0,
                                child: Container(
                                  margin: EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(8.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 8,
                                                offset: Offset(-5, 0),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                                child: Text(
                                                  'Josué Nlandu',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.phone_outlined,
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                              Text(
                                "+243814001432",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.mail_outline,
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                              Text(
                                "jonlandu78@gmail.com",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                        Container(
                          height: 1.0,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                        ListTile(
                          title: Text(
                            'Edit Profil',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          leading: Icon(
                            Icons.edit_outlined,
                            size: 20,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 17,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, Routes.EditProfilePageRoutes);
                          },
                        ),
                        ListTile(
                          title: Text(
                            'My QR Code',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          leading: Icon(
                            Icons.qr_code_outlined,
                            size: 20,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 17,
                          ),
                          onTap: () {
                            showSnackBar(context, "Available soon !");
                          },
                        ),
                        ListTile(
                          title: Text(
                            'Help and Comments ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          leading: Icon(
                            Icons.help_center_outlined,
                            size: 20,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 17,
                          ),
                          onTap: () {
                            showSnackBar(context, "Available soon !");
                          },
                        ),
                        ListTile(
                          title: Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          leading: Icon(
                            Icons.settings_outlined,
                            size: 25,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 17,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, Routes.SettingsPageRoutes);
                          },
                        ),
                        Container(
                          height: 1.0,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                        ListTile(
                          title: Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          leading: Icon(
                            Icons.logout_outlined,
                            size: 20,
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 17,
                          ),
                          onTap: () {
                            openAlertDialog(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  openAlertDialog(context) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Do you really want to logout?"),
          actions: <Widget>[
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(
                    fontSize: 16
                ),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: Text(
                "Confirm",
                style: TextStyle(
                    color: isConfirmButtonPressed
                        ? Color(0xFF0A0094)
                        : Colors.orange,
                    fontSize: 16),
              ),
              onPressed: () {
                setState(() {});
                var ctrl = context.read<UserController>();
                Map data = {};
                ctrl.logout(data);
                Navigator.popAndPushNamed(context, Routes.LoginPageRoutes);
              },
            ),
          ],
        );
      },
    );
    if (result != null) {
      var message = !result ? "Logout canceled" : "Logged out";
      showSnackBar(context, message);
    }
  }

  showSnackBar(context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Ok',
          textColor: Colors.orange,
          onPressed: scaffold.hideCurrentSnackBar,
        ),
      ),
    );
  }
}
