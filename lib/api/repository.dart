import 'dart:convert';
import 'dart:ffi';
import 'package:shop_flutter/model/product.dart';
import 'package:http/http.dart' as http;

class Repository {
  final baseUrl = 'http://127.0.0.1:8000/api';

  //get data with metode async
  Future<Map<String, dynamic>> fetchProducts(int page) async {
    final response = await http.get(Uri.parse('$baseUrl/product?page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Product> products = (data['data']['data'] as List)
          .map((postJson) => Product.fromJson(postJson))
          .toList();
      return {
        'products': products,
        'nextPageUrl': data['data']['next_page_url'],
      };
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> insertProduct(String code, String name, Float price) async {
    final request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/product'));
    request.fields['code'] = code;
    request.fields['name'] = name;
    request.fields['price'] = price.toString();

    final response = await request.send();
    if (response.statusCode == 201) {
      return true;
    } else {
      throw false;
    }
  }

  Future<bool> updateProduct(String code, String name, Float price, int id) async {
    final request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/product/$id'));
    request.fields['code'] = code;
    request.fields['name'] = name;
    request.fields['price'] = price.toString();
    request.fields['_method'] = 'PUT';

    final response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      throw false;
    }
  }

  Future<bool> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/product/$id'));
    if (response.statusCode == 200) {
      return true;
    } else {
      throw false;
    }
  }
}
