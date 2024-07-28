import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:just_complaint/model/complaient_model.dart';
import 'package:just_complaint/model/user_model.dart';
import 'package:just_complaint/service/complaint_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComplaintProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Complaint> _complaints = [];
  String _category = '';
  String _error = '';
  bool _isLoading = false;

  List<Complaint> get complaints => _complaints;
  String get category => _category;
  String get error => _error;
  bool get isLoading => _isLoading;

  ComplaintProvider() {
    loadComplaintsFromPrefs();
  }

  Future<void> submitComplaint(String description, String stdId, String name) async {
    _isLoading = true;
    _error = '';
    _category = '';
    notifyListeners();

    try {
      final category = await _apiService.classifyComplaint(description);
      _category = category;

      final complaint = Complaint(
        description: description,
        category: category,
        status: 'Pending',
        stdId: stdId,
        name: name,
      );
      await _apiService.submitComplaint(complaint);
      _complaints.add(complaint); // Add new complaint to the list
      await _saveComplaintsToPrefs();
    } catch (error) {
      _error = 'Failed to process or save data. Please check the servers and try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchComplaintsByStudentId(String stdId) async {
    if (stdId.isEmpty) {
      _error = 'Student ID is null or empty';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _complaints = await _apiService.fetchComplaintsByStudentId(stdId);
      await _saveComplaintsToPrefs();
    } catch (error) {
      _error = error.toString();
      print('Failed to fetch complaints: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveComplaintsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('complaints', json.encode(_complaints.map((e) => e.toJson()).toList()));
  }

  Future<void> loadComplaintsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final complaintsData = prefs.getString('complaints');
    if (complaintsData != null) {
      _complaints = (json.decode(complaintsData) as List)
          .map((e) => Complaint.fromJson(e))
          .toList();
      notifyListeners();
    }
  }

  Future<void> removeComplaint(String complaintName) async {
    try {
      final isSuccess = await _apiService.deleteComplaint(complaintName);
      if (isSuccess) {
        _complaints.removeWhere((complaint) => complaint.name == complaintName);
        await _saveComplaintsToPrefs();
        notifyListeners();
      } else {
        _error = 'Failed to remove complaint. Please try again.';
        notifyListeners();
      }
    } catch (error) {
      _error = 'An error occurred while removing the complaint.';
      notifyListeners();
    }
  }

  Future<User> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      return User.fromJson(json.decode(userData));
    } else {
      throw Exception('No user found in preferences');
    }
  }
}
