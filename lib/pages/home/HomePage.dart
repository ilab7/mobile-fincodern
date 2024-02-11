import 'package:flutter/material.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/pages/home/NavigationDrawerMenu.dart';
import 'package:mobile_fincopay/pages/news/NotificationsPage.dart';
import 'package:mobile_fincopay/settings/SettingsPage.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
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

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  );

  Widget buildHeader(BuildContext context) => Container(
    color: Color(0xFF040034),
    padding: EdgeInsets.only(
      top: 24 + MediaQuery.of(context).padding.top,
      bottom: 24,
    ),
    child: Column(
      children: [
        CircleAvatar(
          radius: 52,
          //backgroundImage: AssetImage("${userCtrl.user?.image == null ? Image.asset("assets/avatard.png") : userCtrl.user?.image}"),
          backgroundImage: AssetImage("assets/avatard.png"),
        ),
        SizedBox(height: 12,),
        //Text('${userCtrl.user?.fullName==null ? "Name : Undefied" : userCtrl.user?.fullName}',
        Text("Name : Undefied",
        style: TextStyle(
          fontSize: 23,
          color: Colors.white,
        ),
        ),
        //Text('${userCtrl.user?.email == null ? "Email : Undefeid" : userCtrl.user?.email}', style: TextStyle(
        Text("Email : Undefeid", style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),),
      ],
    ),
  );
  Widget buildMenuItems(BuildContext context) => Container(
    padding: EdgeInsets.all(24.0),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: Icon(Icons.home_outlined),
          title: Text('Home'),
          onTap: (){
            Navigator.pushReplacementNamed(context, Routes.BottomNavigationPageRoutes);
          },
        ),
        ListTile(
          leading: Icon(Icons.notifications_outlined),
          title: Text('Notifications'),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationsPage()));
            //Navigator.pushReplacementNamed(context, Routes.NotificationsPageRoutes);
          },
        ),
        ListTile(
          leading: Icon(Icons.settings_outlined),
          title: Text('Settings'),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
          },
        ),
        ListTile(
          leading: Icon(Icons.help_center_outlined),
          title: Text('Help and Comments'),
          onTap: (){
            showSnackBar(context, "Available soon !");
          },
        ),
        Divider(color: Colors.grey,),
        ListTile(
          leading: Icon(Icons.logout_outlined),
          title: Text('Logout'),
          onTap: (){
            openAlertDialog(context);
          },
        ),
      ],
    ),
  );

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
                    fontSize: 16),
              ),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              child: Text(
                "Confirm",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 16),),
              onPressed: () {
                //setState(() {});
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