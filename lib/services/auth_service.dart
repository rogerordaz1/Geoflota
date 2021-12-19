import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = "152.206.177.70:1337";
  final String apiToken = "";
  final storage = const FlutterSecureStorage();
  bool navegar = false;

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

    if (response.statusCode == 200) {
      navegar = true;
    } else {}

    final Map<String, dynamic> decodedResp = json.decode(response.body);

    if (decodedResp.containsKey('jwt')) {
      await storage.write(key: 'token', value: decodedResp['jwt']);
      return null;
    } else {
      return decodedResp['message'][0]["messages"][0]["message"];
    }

    //  print(x);
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }
}
