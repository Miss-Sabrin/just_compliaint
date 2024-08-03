import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  Future<User> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/loginuser'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'email': email, 'password': password}),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['message'] == 'Login Successfull') {
        User user = User.fromJson(responseData['user']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', json.encode(user.toJson()));
        return user;
      } else {
        throw Exception(responseData['message']);
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<User> signupUser(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'name': name, 'email': email, 'password': password}),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      return User.fromJson(responseData['user']);
    } else {
      throw Exception('Failed to signup');
    }
  }

  Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user');
    if (userData != null) {
      return User.fromJson(json.decode(userData));
    }
    return null;
  }

//   //response type
Future<int> getNewResponsesCount(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/new-responses-count/$userId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['newResponsesCount'] ?? 0;

    } else {
      throw Exception('Failed to load new responses count');
    }
  }

  Future<void> resetNewResponsesCount(String userId) async {
    final response = await http.post(Uri.parse('$baseUrl/reset-new-responses/$userId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to reset new responses count');
    }
  }
} 