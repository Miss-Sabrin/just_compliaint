import 'package:flutter/material.dart';
import 'package:just_complaint/model/respnse_model.dart';
import 'package:just_complaint/service/response_service.dart';

class ResponseProvider with ChangeNotifier {
  List<Response> _responses = [];
  String _error = '';
  bool _isLoading = false;
  final ResponseService _responseService = ResponseService();

  List<Response> get responses => _responses;
  String get error => _error;
  bool get isLoading => _isLoading;

  Future<void> fetchResponses(String userId) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _responses = await _responseService.fetchResponses(userId);
    } catch (error) {
      _error = 'An error occurred: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteResponse(String id) async {
    try {
      await _responseService.deleteResponse(id);
      _responses.removeWhere((response) => response.id == id);
      notifyListeners();
    } catch (error) {
      _error = 'An error occurred while deleting the response: $error';
      notifyListeners();
    }
  }
}
