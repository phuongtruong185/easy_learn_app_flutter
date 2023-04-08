import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../net/api.dart';

class CartController extends GetxController {
  RxList<dynamic> products = RxList<dynamic>();
  RxInt total = 0.obs;
  RxInt priceDiscount = 0.obs;
  RxInt quantityOrdered = 0.obs;

  Future<void> fetchData() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      String access_token = prefs.getString('access_token')!;
      access_token = access_token.replaceAll('"', '');

      var response = await API.get('/cart', headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $access_token'
      });
      if (response['success'] == true) {
        List<dynamic> productsData =
            jsonMapToList(response['listCourse']['courseId']);

        products.assignAll(productsData);
        total.value = response['listCourse']['price'];
        priceDiscount.value = response['listCourse']['price_discount'];
        quantityOrdered.value = response['listCourse']['quantityOrdered'];
      } else if (response.hasError) {
        // Xử lý lỗi nếu có
        // ...
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      // ...
    }
  }

  // Hàm chuyển đổi từ jsonMap sang List<dynamic>
  List<dynamic> jsonMapToList(data) {
    List list = [];
    for (var item in data) {
      list.add(item);
    }
    return list;
  }
}
