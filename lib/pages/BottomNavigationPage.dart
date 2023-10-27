import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_fincopay/pages/home/HomePage.dart';
import 'package:mobile_fincopay/pages/user/ProfilPage.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {

  int _currentIndex = 0;
  Color other = Colors.grey;
  Color selectedItem = Colors.orange;
  GetStorage box = GetStorage();

  final pages = [
    HomePage(),
    ProfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: _bottomNavigation(),
    );
  }

  Widget _bottomNavigation(){
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, -2), // Décalage vers le haut pour l'ombre
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        unselectedItemColor: other,
        selectedItemColor: selectedItem,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
            other = Colors.grey;
            selectedItem = Colors.orange;
          });
        },
      ),
    );
  }
}