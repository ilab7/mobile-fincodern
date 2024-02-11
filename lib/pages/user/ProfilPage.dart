import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/utils/StockageKeys.dart';
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

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userCtrl = context.read<UserController>();
      userCtrl.getDataAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: SizedBox(width: 0,),
        title: Text(
          'Profil',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Color(0xFF040034),
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
                    child: _body(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(){
    var userCtrl = context.watch<UserController>();
    var token = box.read(StockageKeys.tokenKey);
    print("TOKEN :::::::::::::::::::: $token");

    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.30,
                child: Center(
                  child: CircleAvatar(
                    radius: 52,
                    child: CircleAvatar(
                      radius: 52,
                      backgroundImage: AssetImage("${userCtrl.user?.image == null ? "assets/avatard.png" : userCtrl.user?.image!}"),
                    ),
                  ),
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
                                  '${userCtrl.user?.fullName==null ? "Name : Undefied" : userCtrl.user?.fullName}',
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
                "${userCtrl.user?.phone == null ? "Phone : Undefied" : userCtrl.user?.phone}",
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
                "${userCtrl.user?.email == null ? "Email : Undefeid" : userCtrl.user?.email}",
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
        Container(
          height: 1.0,
          width: double.infinity,
          color: Colors.grey,
        ),
        ListTile(
          title: Text(
            'Log out',
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
                Navigator.pushNamedAndRemoveUntil(context, Routes.LoginPageRoutes, ModalRoute.withName('/homepage'),);
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
