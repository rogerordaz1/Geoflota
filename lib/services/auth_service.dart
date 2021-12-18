import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = "http://152.206.177.70:1337";
  final String apiToken = "";

  Future<String?> loginUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'identifier': email,
      'password': password,
    };

    final url = Uri.https(_baseUrl, 'auth/local');

    final response = await http.post(url, body: jsonEncode(authData));
    final Map<String, dynamic> decodedResp = jsonDecode(response.body);
  }
}
