// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:4000';

  Future<void> registerUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      print('User registered successfully!');
      _logRegistration(userData); // Call to log registration
    } else {
      print('Failed to register user: ${response.body}');
    }
  }

  Future<void> loginUser(Map<String, dynamic> loginData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginData),
    );

    if (response.statusCode == 200) {
      print('Login successful: ${response.body}');
    } else {
      print('Login failed: ${response.body}');
    }
  }

  Future<void> _logRegistration(Map<String, dynamic> userData) async {
    // This could be an API call to log registration data or simply print it
    // For demonstration, we'll just print the log details
    // Replace this with actual logging logic (e.g., API call) if needed
    final logData = {
      'event': 'User Registration',
      'user': userData,
      'timestamp': DateTime.now().toIso8601String(),
    };

    // Simulating logging to an API
    final logResponse = await http.post(
      Uri.parse('$baseUrl/logs'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(logData),
    );

    if (logResponse.statusCode == 200) {
      print('Registration logged successfully: ${logResponse.body}');
    } else {
      print('Failed to log registration: ${logResponse.body}');
    }
  }
}
