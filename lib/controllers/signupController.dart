import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Success!',
          message: 'Gửi mã OTP thành công. Vui lòng kiểm tra email và điền mã OTP',
          contentType: ContentType.success,
          inMaterialBanner: true,
        ),
      );
      Navigator.pushNamed(context, '/verify-sign-up');
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
