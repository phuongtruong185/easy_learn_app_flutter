import 'dart:convert';
import 'package:easy_learn_app/models/signup_model.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
 

class SignupController extends GetxController {
  var isLoading = false.obs;

  Future<void> signUp(String email, String phone, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var formData = Sigup(email, phone);
    isLoading(true);
    var response = await API.post('/auth/register',
        body: formData.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });
    isLoading(false);
    if (response['message'] == 'Send OTP thành công') {
      prefs.setString('email', email);
      prefs.setString('phone', phone);
      Navigator.pushNamed(context, '/verify-sign-up');
    } else {
      print('Error during signup');
    }
  }
}
