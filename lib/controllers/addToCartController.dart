import 'package:get/get.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/addtoCart_model.dart';

class AddToCartController extends GetxController {
  var isLoading = false.obs;

  Future<void> addToCart(dynamic course, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString('access_token')!;
    access_token = access_token.replaceAll('"', '');

    var formData = AddToCart(course['_id']);
    isLoading(true);
    var response = await API.post('/cart', body: formData.toJson(), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token',
    });

    // print status code
    print(response.statusCode);

    print(response);

    isLoading(false);
  }
}
