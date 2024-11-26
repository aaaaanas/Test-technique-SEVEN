import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/user.dart';

class ApiService {
  static Future<List<User>> fetchUsers(int page) async {
    final response = await http.get(Uri.parse('https://dummyjson.com/users?page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<User>.from(data['users'].map((x) => User.fromJson(x)));
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<List<Product>> fetchProducts(int page) async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products?page=$page'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return List<Product>.from(data['products'].map((x) => Product.fromJson(x)));
    } else {
      throw Exception('Failed to load products');
    }
  }
}
