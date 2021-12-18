import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = "152.206.177.70:1337";
  final String apiToken = "";

  Future<String?> loginUser(String correo, String password) async {
    final Map<String, dynamic> authData = {
      "identifier": correo,
      "password": password,
    };

    final url = Uri.http(_baseUrl, '/auth/local');

    final response = await http.post(url, body: {
      'identifier': authData['identifier'],
      'password': authData['password']
    });
    final Map<String, dynamic> decodedResp = json.decode(response.body);
    print(decodedResp);
  }
}
