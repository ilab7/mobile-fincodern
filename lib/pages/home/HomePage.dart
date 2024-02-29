import 'package:flutter/material.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/pages/home/NavigationDrawerMenu.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userCtrl = context.read<UserController>();
      userCtrl.getDataAPI();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: _appBar(context),
    drawer: NavigationDrawerMenu(),
    body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(06.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Home Page',
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
                'Page under development',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

AppBar _appBar(BuildContext context){
  var userCtrl = context.watch<UserController>();
  return AppBar(
    actions: [
      Container(
        height: 45,
        child: CircleAvatar(
          radius: 52,
          backgroundImage: AssetImage("${userCtrl.user?.image == null ? "assets/avatard.png" : userCtrl.user?.image!}"),
        ),
      ),
    ],
    backgroundColor: Color(0xFF040034),
    iconTheme: IconThemeData(color: Colors.white), //Change the color of the menu icon
  );
}