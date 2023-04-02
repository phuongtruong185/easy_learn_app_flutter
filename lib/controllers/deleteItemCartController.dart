import 'package:get/get.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/addtoCart_model.dart';

class DeleteItemCartController extends GetxController {
  var isLoading = false.obs;

  Future<void> deleteItemCart(dynamic course, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString('access_token')!;
    access_token = access_token.replaceAll('"', '');
    print(course['_id']);
    var formData = AddToCart(course['_id']);
    isLoading(true);
    var response = await API.delete('/cart', body: formData.toJson(), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token',
    });
    isLoading(false);
    if (response['success'] == true) {
      Get.snackbar('Success', 'Đã xoá khóa học',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Error', 'Xảy ra lỗi!. Vui lòng thử lại sau',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
