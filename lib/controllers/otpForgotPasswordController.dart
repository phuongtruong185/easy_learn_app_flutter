import 'package:easy_learn_app/models/otpForgotPassword_model.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPForgotPasswordController extends GetxController {
  var isLoading = false.obs;

  Future<void> otpForgotPassword(String email, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var formData = OtpForgotPassword(email);
    isLoading(true);
    var response = await API.post('/auth/otpForgotPassword',
        body: formData.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });
    isLoading(false);
    if (response['message'] == 'Send OTP thành công') {

      prefs.setString('emailForgotPass', email);
      Navigator.pushNamed(context, '/verify-forgot-password');
    } else {
      print('Error during send otp forgot password');
    }
  }
}
