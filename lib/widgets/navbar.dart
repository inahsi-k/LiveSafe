
import 'package:flutter/material.dart';
import 'package:jansuraksha/constants/colors.dart';
import 'package:jansuraksha/screens/alert_screen.dart';
import 'package:jansuraksha/screens/profile.dart';

class BottomNavWithCustomFab extends StatefulWidget {
  const BottomNavWithCustomFab({super.key});

  @override
  _BottomNavWithCustomFabState createState() => _BottomNavWithCustomFabState();
}

class _BottomNavWithCustomFabState extends State<BottomNavWithCustomFab> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
   AlertScreen(), Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomAppBar(
        height: 55,
        color:const Color.fromARGB(255, 101, 10, 139),
        shape: CircularNotchedRectangle(), // notch for FAB
        notchMargin:4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home,size: 35,),
              color:_selectedIndex==0?buttonColor:Colors.white,
              onPressed: () => _onItemTapped(0),
            ),
            SizedBox(width: 40), // space for FAB
            IconButton(
              icon: Icon(Icons.person,size: 35),
              color:_selectedIndex==1?buttonColor:Colors.white,
              onPressed: () => _onItemTapped(1),
            ),
          ],
        ),
      ),

      floatingActionButton: SizedBox(
        height:80,
        width: 80,
        child: FloatingActionButton(
          backgroundColor: buttonColor,
          onPressed: () {
          },
          child: Icon(Icons.safety_check,size: 40,), // ya koi aur icon
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
