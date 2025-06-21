// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:jansuraksha/constants/colors.dart';
import 'package:jansuraksha/services/risk_predictor_api.dart';
import 'package:jansuraksha/widgets/custom_text.dart';
import 'package:jansuraksha/widgets/drop_down.dart';
import 'package:jansuraksha/widgets/textfield.dart';

class RiskLevelPredictor extends StatefulWidget {
  const RiskLevelPredictor({super.key});

  @override
  State<RiskLevelPredictor> createState() => _RiskLevelPredictorState();
}

class _RiskLevelPredictorState extends State<RiskLevelPredictor> {
  TextEditingController cityController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  List<String> gender = ["Female", "Male", "Others"];
  String? selectedGender;
  bool update = false;
  bool isLoading = false;
  int genderValue = 0;
  Map<String, dynamic> data = {};
  void predictApi() async {
    try {
      setState(() {
        update = true;
        isLoading = true;
      });
      data = await ApiServices().riskPredict(
        city: cityController.text,
        age: int.tryParse(ageController.text) ?? 0,
        gender: genderValue,
      );
      setState(() {
        isLoading = false;
      });
    } catch (err) {
      setState(() {
        update = false;
        isLoading = false;
        data = {'error': "Error fetching data"};
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error fetching data:$err")));
      print(err);
    }
  }

  @override
  void dispose() {
    cityController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: bgcolor,
        title: Center(
          child: CustomText(
            text: "Risk level predictor",
            size: 28,
            color: Colors.white,
            weight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                //height: 300,
                width: double.infinity,
                //color: Colors.amber,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow:[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6), // Red shadow
                      offset: Offset(-2, 6), // X, Y position
                      blurRadius: 11,       // Soften the shadow
                      spreadRadius: 1,      // Expand the shadow
                    ),
                  ], 
                  gradient: LinearGradient(
                    
                    colors: [
                      //const Color.fromARGB(255, 251, 44, 33),
                      const Color.fromARGB(255, 255, 77, 67),
                      const Color.fromARGB(255, 255, 95, 86),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 25.0,
                    horizontal: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFieldWidget(
                        controller: cityController,
                        text: "Enter city",
                        filled: true,
                      ),
                      SizedBox(height: 20),
                      TextFieldWidget(
                        controller: ageController,
                        text: "Enter age",
                        filled: true,
                      ),
                      SizedBox(height: 20),
                      MyDropdownWidget(
                        text: "Select gender",
                        items: gender,
                        onChanged: (val) {
                          setState(() {
                            selectedGender = val;
                            genderValue =
                                val == "Female"
                                    ? 0
                                    : val == "Male"
                                    ? 1
                                    : 2;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          predictApi();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: bgcolor,
                          foregroundColor: Colors.white,
                        ),
                        child: CustomText(
                          text: "Predict",
                          size: 20,
                          color: Colors.white,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18),
              !update
                  ? Container()
                  : Container(
                    width: double.infinity,
                    //color: Colors.amber,
                    decoration: BoxDecoration(
                      boxShadow:[
                        BoxShadow(
                          color: Colors.red.withOpacity(0.6), // Red shadow
                          offset: Offset(-2, 6), // X, Y position
                          blurRadius: 15,       // Soften the shadow
                          spreadRadius: 2,      // Expand the shadow
                        ),
                      ], 
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          //const Color.fromARGB(255, 251, 44, 33),
                          const Color.fromARGB(255, 249, 247, 247),
                          const Color.fromARGB(255, 255, 255, 255),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child:
                          isLoading
                              ? Center(child: CircularProgressIndicator())
                              : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text:
                                        "Predicted Risk level:${data["predicted_risk_level"]}",
                                    size: 20,
                                    color: Colors.black,
                                    weight: FontWeight.w800,
                                  ),
                                  SizedBox(height: 8),
                                  CustomText(
                                    text: "City: ${data["details"]["City"]}",
                                    size: 17,
                                    color: Colors.black,
                                    weight: FontWeight.normal,
                                  ),
                                  SizedBox(height: 8),
                                  CustomText(
                                    text: "Gender: ${gender[data["details"]["Gender"]]}",
                                    size: 17,
                                    color: Colors.black,
                                    weight: FontWeight.normal,
                                  ),
                                  SizedBox(height: 8),
                                  CustomText(
                                    text: "Hour: ${data["details"]["Hour"]}",
                                    size: 17,
                                    color: Colors.black,
                                    weight: FontWeight.normal,
                                  ),
                                  SizedBox(height: 8),
                                  CustomText(
                                    text: "Month: ${data["details"]["Month"]}",
                                    size: 17,
                                    color: Colors.black,
                                    weight: FontWeight.normal,
                                  ),
                                ],
                              ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
