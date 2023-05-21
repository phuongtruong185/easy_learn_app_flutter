import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/addtoCart_model.dart';
import 'cartController.dart';

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

    if (response['success'] == true) {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Success!',
          message: 'Đã thêm vào giỏ hàng',
          contentType: ContentType.success,
          inMaterialBanner: true,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Get.find<CartController>().fetchData();
    } else {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: response['message'],
          contentType: ContentType.failure,
          inMaterialBanner: true,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    isLoading(false);
  }
}
