import 'package:flutter/material.dart';
import 'package:just_complaint/model/complaient_model.dart';
import 'package:just_complaint/model/user_model.dart';
import 'package:just_complaint/service/complaint_service.dart';

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
    } catch (error) {
      _error = 'Failed to process or save data. Please check the servers and try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchComplaintsByStudentId(String stdId) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _complaints = await _apiService.fetchComplaintsByStudentId(stdId);
    } catch (error) {
      _error = error.toString();
      print('Failed to fetch complaints: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<User> getCurrentUser() async {
    return await _apiService.getCurrentUser();
  }
}
