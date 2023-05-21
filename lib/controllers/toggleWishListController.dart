import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_learn_app/controllers/wishListController.dart';
import 'package:easy_learn_app/models/wishList_model.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../widget/ItemsWidget.dart';
import 'ItemsWidgetController.dart';

class ToggleWishListController extends GetxController {
  var isLoading = false.obs;

  Future<void> toggleWishList(dynamic course, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString('access_token')!;
    access_token = access_token.replaceAll('"', '');

    var formData = WishList(course['_id']);
    isLoading(true);

    var response = await API.post('/courseWishList', body: formData.toJson(), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token',
    });
    isLoading(false);
    if (response['success']) {
      Get.find<WishListController>().wishList();
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Success!',
          message: response['message'],
          contentType: ContentType.success,
          inMaterialBanner: true,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      ItemsController.fetchData();
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
  }
}
