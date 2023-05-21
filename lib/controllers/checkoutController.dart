import 'package:flutter/material.dart';

import 'package:easy_learn_app/net/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/checkout_model.dart';

class CheckoutController extends GetxController {
  var isLoading = false.obs;

  Future<void> checkout(dynamic cartId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString('access_token')!;
    access_token = access_token.replaceAll('"', '');

    var formData = Checkout(cartId);
    isLoading(true);
    var response = await API.post('/pay', body: formData.toJson(), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $access_token'
    });
    isLoading(false);
    if (response['url'] != null) {
      String url = response['url'];
      await launch(url);
      await Navigator.pushNamed(context, '/');
    }
  }
}
