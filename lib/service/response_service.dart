import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:just_complaint/constant/constan.dart';
import 'package:just_complaint/model/respnse_model.dart';

class ResponseService {
  Future<List<Response>> fetchResponses(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/responses/$userId'));

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      return responseData.map((json) => Response.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load responses');
    }
  }

  Future<void> deleteResponse(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/delResponses/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete response');
    }
  }
}
