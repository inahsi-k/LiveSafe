import 'package:flutter/material.dart';
import 'package:jansuraksha/constants/colors.dart';
import 'package:jansuraksha/screens/alert_screen.dart';
import 'package:jansuraksha/screens/home.dart';
import 'package:jansuraksha/screens/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({super.key});
  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int index = 0;
  int page = 0;

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 35, color: Colors.white),
      Icon(Icons.emergency_outlined, size: 35, color: Colors.white),
      Icon(Icons.person, size: 35, color: Colors.white),
    ];

    final pages = [Home(), AlertScreen(), Profile()];
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65,
        backgroundColor: page == 1 ? bgcolor : Colors.white,
        color: const Color.fromARGB(255, 169, 26, 194),
        buttonBackgroundColor: Colors.red,
        items: items,
        index: index,
        onTap: (index) {
          // Handle navigation or state update here
          setState(() {
            page = index;
          });
        },
      ),
      body: pages[page],
    );
  }
}
