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
      if (responseData['message'] == 'success') {
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

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}