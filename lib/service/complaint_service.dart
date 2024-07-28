import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/model/complaient_model.dart';
import 'package:just_complaint/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {

  Future<List<Complaint>> fetchComplaintsByStudentId(String stdId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/studentData/$stdId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Complaint.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch student data');
    }
  }

  Future<String> classifyComplaint(String description) async {
    final response = await http.post(
      Uri.parse('$flaskBaseUrl/predict'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'text': description}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['category'];
    } else {
      throw Exception('Failed to classify complaint');
    }
  }

  Future<void> submitComplaint(Complaint complaint) async {
    final response = await http.post(
      Uri.parse('$baseUrl/complaints'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(complaint.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to submit complaint');
    }
  }

  Future<User> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
    if (userData != null) {
      return User.fromJson(json.decode(userData));
    } else {
      throw Exception('No user data found');
    }
  }

  Future<bool> deleteComplaint(String complaintName) async {
    final url = '$baseUrl/deleteComplaint';  // Update with your actual API endpoint
    final response = await http.delete(
      Uri.parse(url),
      body: json.encode({'name': complaintName}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
