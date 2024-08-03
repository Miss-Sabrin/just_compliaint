import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:just_complaint/model/user_model.dart';
import 'package:just_complaint/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
   int _newResponsesCount = 0;
  User? _user;
  String _error = '';
  final UserService _userService = UserService();

  User? get user => _user;
  String get error => _error;
  int get newResponsesCount => _newResponsesCount;
  UserProvider() {
    loadUserFromPrefs();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      _user = await _userService.loginUser(email, password);
      _error = '';
      await _saveUserToPrefs();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> logoutUser() async {
    _user = null;
    _error = '';
    await _clearUserFromPrefs();
    notifyListeners();
  }

  Future<void> _saveUserToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', json.encode(_user!.toJson()));
  }

  Future<void> _clearUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      _user = User.fromJson(json.decode(userData));
      notifyListeners();
    }
  }
  // //todo response badget
// // Add new response locally
  void addResponse() {
    _newResponsesCount++;
    notifyListeners();
  }

  // Reset new response count
  void resetNewResponsesCount() {
    _newResponsesCount = 0;
    notifyListeners();
  }
}