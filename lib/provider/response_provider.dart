import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/model/respnse_model.dart';

class ResponseProvider with ChangeNotifier {
  List<Response> _responses = [];
  String _error = '';
  bool _isLoading = false;
 
  List<Response> get responses => _responses;
  String get error => _error;
  bool get isLoading => _isLoading;

  Future<void> fetchResponses(String userId) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('$baseUrl/responses/$userId'));

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);
        _responses = responseData.map((json) => Response.fromJson(json)).toList();
      } else {
        _error = 'Failed to load responses';
      }
    } catch (error) {
      _error = 'An error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteResponse(String id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/delResponses/$id'));

      if (response.statusCode == 200) {
        _responses.removeWhere((response) => response.id == id);
        notifyListeners();
      } else {
        _error = 'Failed to delete response';
        notifyListeners();
      }
    } catch (error) {
      _error = 'An error occurred while deleting the response';
      notifyListeners();
    }
  }







}
