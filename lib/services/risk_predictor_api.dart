// ignore_for_file: avoid_print
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiServices {
  Future<Map<String, dynamic>> riskPredict({
    required String city,
    required int age,
    required int gender,
  }) async {
    final url = Uri.parse(
      'https://crime-risk-level-classifier.onrender.com/predict/',
    );
    final response = await http.post(
      url,
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'city': city,
        'age': age.toString(),
        'gender': gender.toString(),
      }),
    );
    if (response.statusCode == 201||response.statusCode==200) {
      print("success");
      return jsonDecode(response.body);
    } else {
      throw Exception('API Error: ${response.statusCode}');
    }
  }
}
