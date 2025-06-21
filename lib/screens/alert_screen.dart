import 'package:flutter/material.dart';
import 'package:jansuraksha/constants/colors.dart';
import 'package:jansuraksha/widgets/custom_alert_button.dart';
import 'package:jansuraksha/widgets/custom_text.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgcolor,
        title: Center(
          child: CustomText(
            text: "LiveSafe",
            size: 28,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 15),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.1), // adjust to control overlap
                  child: Image.asset(
                    "assets/hands.png",
                    fit: BoxFit.fill,
                    width: 350,
                    height: 280,
                  ),
                ),
                
                PhysicalModel(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  shadowColor: Colors.black,
                  elevation: 10,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/map.png",
                      fit: BoxFit.cover,
                      width: 180,
                      height: 180,
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: CustomAlertButton(
                    svg: "assets/signal.svg",
                    text: "Scan zone",
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CustomAlertButton(
                    svg: "assets/rec.svg",
                    text: "Go live",
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CustomAlertButton(
                    svg: "assets/police.svg",
                    text: "Alert Police",
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: CustomAlertButton(
                    svg: "assets/message.svg",
                    text: "Message Alert",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      
    );
  }
}
