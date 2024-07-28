import 'package:flutter/material.dart';
import 'package:just_complaint/model/complaient_model.dart';
import 'package:just_complaint/service/student_info_api.dart';

class StudentDataProvider with ChangeNotifier {
  final StudentInfoApi _studentInfoApi = StudentInfoApi();
  List<Complaint> _stdData = [];
  String _error = '';
  bool _isLoading = false;

  List<Complaint> get stdData => _stdData;
  String get error => _error;
  bool get isLoading => _isLoading;

  Future<void> fetchStudentData(String stdId) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _stdData = await _studentInfoApi.fetchStudentData(stdId);
    } catch (error) {
      _error = 'Failed to fetch student data. Please check the servers and try again.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  
}

 