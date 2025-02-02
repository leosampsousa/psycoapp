import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teste/exception/ApiException.dart';

class Authservice {
  static final String baseUrl = "http://10.0.2.2:8080";

  static Future<String?> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final Map<String, String> requestBody = {
      'username': username,
      'password': password
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(requestBody),
    );
    final Map<String, dynamic> loginResponse = json.decode(response.body);
    if (response.statusCode == 200) {
      final String token = loginResponse["token"];
      await saveToken(token);
      return token;
    }
    throw Apiexception(loginResponse['mensagem']);
  }

  static Future<bool> isUsernameAvailable(String username) async {
    final url = Uri.parse('$baseUrl/auth/login/available');
    final Map<String, String> requestBody = {
      'username': username,
    };

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  static Future<void> register(
      String username, String password, String nome, String sobrenome) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final Map<String, String> requestBody = {
      'username': username,
      'password': password,
      'firstName': nome,
      'lastName': sobrenome
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(requestBody),
    );

    if (response.statusCode != 201) {
      final Map<String, dynamic> registerResponse = json.decode(response.body);
      throw Apiexception(registerResponse['mensagem']);
    }
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }
}
