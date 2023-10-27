import 'package:flutter/material.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/pages/news/NotificationsPage.dart';
import 'package:mobile_fincopay/settings/SettingsPage.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      actions: [
        InkWell(
          onTap: (){
            Navigator.pushReplacementNamed(context, Routes.ProfilPageRoutes);
          },
          child: Container(
            height: 50,
            padding: EdgeInsets.all(5.0),
            child: Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset("assets/josuenlandu.jpg")
              ),
            ),
          ),
        ),
        /*Theme(
          data: Theme.of(context).copyWith(
              dividerColor: Colors.black,
              iconTheme: IconThemeData(color: Colors.orange)),
          child: PopupMenuButton<int>(
            color: Colors.white,
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  value: 1,
                  child: InkWell(
                    onTap: () {
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.language_outlined,
                          color: Colors.orange,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text("Short by date", style: TextStyle(color: Colors.black),)
                      ],
                    ),
                  )),
              PopupMenuDivider(),
              PopupMenuItem<int>(
                  value: 2,
                  onTap: () async {

                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 7,
                      ),

                      Text("Delete all",style: TextStyle(color: Colors.black))
                    ],
                  )),
            ],
          ),
        )*/
      ],
      backgroundColor: Color(0xFF040034),
    ),
    drawer: NavigationDrawer(),
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
          backgroundImage: AssetImage("assets/josuenlandu.jpg"),
        ),
        SizedBox(height: 12,),
        Text('Josué Nlandu',
        style: TextStyle(
          fontSize: 23,
          color: Colors.white,
        ),
        ),
        Text('jonlandu78@gmail.com', style: TextStyle(
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