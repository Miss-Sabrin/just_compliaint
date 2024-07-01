import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/model/complaient_model.dart';


class StudentInfoApi {
 // final String baseUrl = 'http://10.0.2.2:9000/api';

  Future<List<Complaint>> fetchStudentData(String stdId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/studentData/$stdId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData.map((json) => Complaint.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch student data');
    }
  }
}
