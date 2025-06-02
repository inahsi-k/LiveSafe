import 'package:flutter/material.dart';
import 'package:jansuraksha/widgets/custom_text.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: CustomText(text: "profile", size: 20, color: Colors.orangeAccent, weight: FontWeight.normal)),
    );
  }
}