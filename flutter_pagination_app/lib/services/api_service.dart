import 'dart:convert';

import 'package:flutter_pagination_app/models/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiUrl = 'https://your-api-url.com'; // Replace with your API URL

  // Fetch user details by ID
  static Future<User> fetchUserById(String id) async {
    final response = await http.get(Uri.parse('$apiUrl/users/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user');
    }
  }

  static fetchProductById(String productId) {}

  static fetchProducts(int page) {}

  static fetchUsers(int page) {}
}
