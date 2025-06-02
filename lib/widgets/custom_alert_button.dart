import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jansuraksha/widgets/custom_text.dart';

class CustomAlertButton extends StatelessWidget {
  final String svg;
  final String text;
  const CustomAlertButton({super.key, required this.svg, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          elevation: 5,
          color: const Color.fromARGB(255, 255, 95, 86),
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              children: [
                SvgPicture.asset(svg,
                  width: 55,
                  height: 55,
                ),
                SizedBox(
                  height: 9,
                ),
                CustomText(text: text, size: 18, color: Colors.white, weight: FontWeight.bold)
              ],
            ),
          ),
        ),
      
    );
  }
}
