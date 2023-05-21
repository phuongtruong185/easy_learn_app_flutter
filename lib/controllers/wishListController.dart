import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishListController extends GetxController {
  var isLoading = false.obs;
  RxList<dynamic> wishListItem = RxList<dynamic>();

  Future<void> wishList() async {
    try {
      var prefs = await SharedPreferences.getInstance();
      String access_token = prefs.getString('access_token')!;
      access_token = access_token.replaceAll('"', '');

      isLoading(true);
      var response = await API.get('/courseWishList', headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $access_token'
      });

      if (response['success'] == true) {
        List<dynamic> data = jsonMapToList(response['data']);
        wishListItem.assignAll(data);
      }

      isLoading(false);
    } catch (e) {
      // Xử lý lỗi nếu có
      // ...
    }
  }

  List<dynamic> jsonMapToList(data) {
    List list = [];
    for (var item in data) {
      list.add(item);
    }
    return list;
  }
}
