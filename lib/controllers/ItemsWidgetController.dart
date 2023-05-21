import 'package:easy_learn_app/net/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class ItemsController {
  static Future<List<dynamic>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString('access_token')!;
    access_token = access_token.replaceAll('"', '');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token'
    };

    final response = await API.get('/course', headers: headers);
    if (response != null && response['data'] != null) {
      return response['data'] as List<dynamic>;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
