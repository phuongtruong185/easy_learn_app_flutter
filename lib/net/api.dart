import 'package:dio/dio.dart';
import 'dart:convert';

class API {
  static var dio = Dio();
  static var baseUrl =
      'https://backendeasylearnfinal-production.up.railway.app';

  static Future get(String url, {Map<String, dynamic>? headers}) async {
    try {
      var response =
          await dio.get(baseUrl + url, options: Options(headers: headers));
      return json.decode(response.toString());
    } catch (e) {
      print('Error during GET request: $e');
      rethrow;
    }
  }

  static Future post(String url,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    try {
      var response = await dio.post(baseUrl + url,
          data: body, options: Options(headers: headers));
      return json.decode(response.toString());
    } catch (e) {
      print('Error during POST request: $e');
      rethrow;
    }
  }

  static Future put(String url, {required Map<String, dynamic> body}) async {
    try {
      var response = await dio.put(baseUrl + url, data: body);
      return json.decode(response.toString());
    } catch (e) {
      print('Error during PUT request: $e');
      rethrow;
    }
  }

  static Future delete(String url,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    try {
      var response = await dio.delete(baseUrl + url,
          data: body, options: Options(headers: headers));
      return json.decode(response.toString());
    } catch (e) {
      print('Error during DELETE request: $e');
      rethrow;
    }
  }

  static Future patch(String url, {required Map<String, dynamic> body}) async {
    try {
      var response = await dio.patch(baseUrl + url, data: body);
      return json.decode(response.toString());
    } catch (e) {
      print('Error during PATCH request: $e');
      rethrow;
    }
  }
}
