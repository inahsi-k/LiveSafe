import 'package:flutter/material.dart';
import 'package:jansuraksha/widgets/custom_text.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: CustomText(text: "home", size: 20, color: Colors.orangeAccent, weight: FontWeight.normal)),
    );
  }
}