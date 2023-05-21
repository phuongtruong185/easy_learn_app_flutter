import 'package:dio/dio.dart';
import 'dart:convert';

class API {
  static var dio = Dio();
  static var baseUrl = 'https://easy-learn-final-production-v1.up.railway.app';

  static Future get(String url, {Map<String, dynamic>? headers}) async {
    try {
      var response =
          await dio.get(baseUrl + url, options: Options(headers: headers));
      return json.decode(response.toString());
    } on DioError catch (e) {
      if (e.response?.statusCode != null && e.response!.statusCode != 200) {
        return json.decode(e.response.toString());
      }
      rethrow;
    }
  }

  static Future post(String url,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    try {
      var response = await dio.post(baseUrl + url,
          data: body, options: Options(headers: headers));
      return json.decode(response.toString());
    } on DioError catch (e) {
      if (e.response?.statusCode != null && e.response!.statusCode != 200) {
        return json.decode(e.response.toString());
      }
      rethrow;
    }
  }

  static Future patch(String url,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    try {
      var response = await dio.patch(baseUrl + url,
          data: body, options: Options(headers: headers));
      return json.decode(response.toString());
    } on DioError catch (e) {
      if (e.response?.statusCode != null && e.response!.statusCode != 200) {
        return json.decode(e.response.toString());
      }
      rethrow;
    }
  }

  static Future put(String url, {required Map<String, dynamic> body}) async {
    try {
      var response = await dio.put(baseUrl + url, data: body);
      return json.decode(response.toString());
    } on DioError catch (e) {
      if (e.response?.statusCode != null && e.response!.statusCode != 200) {
        return json.decode(e.response.toString());
      }
      rethrow;
    }
  }

  static Future delete(String url,
      {Map<String, dynamic>? body, Map<String, dynamic>? headers}) async {
    try {
      var response = await dio.delete(baseUrl + url,
          data: body, options: Options(headers: headers));
      return json.decode(response.toString());
    } on DioError catch (e) {
      if (e.response?.statusCode != null && e.response!.statusCode != 200) {
        return json.decode(e.response.toString());
      }
      rethrow;
    }
  }
}
