import 'dart:convert';
import 'package:easy_learn_app/models/login_model.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  Future<void> login(String email, String password, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var formData = Login(email, password);
    isLoading(true);
    var response = await API.post('/auth/login',
        body: formData.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });
    isLoading(false);
    if (response['access_token'] != null) {
      prefs.setString('access_token', jsonEncode(response['access_token']));
      Navigator.pushNamed(context, '/home');
    } else {
      print('Error during login');
    }
  }
}
