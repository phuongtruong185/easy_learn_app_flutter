import 'package:easy_learn_app/net/api.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/verifyForgotPassword_model.dart';


class VerifyForgotPasswordController extends GetxController {
  var isLoading = false.obs;

  Future<void> verifyForgotPassword(String email, String otp, String password, context) async {
    var formData = VerifyForgotPassword(email, otp, password);
    isLoading(true);
    print(formData.toJson());
    var response = await API.post('/auth/verifyOtpForgotPassword',
        body: formData.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });
    isLoading(false);
    print(response);
    if (response['message'] == 'Đặt lại mật khẩu thành công') {
      Navigator.pushNamed(context, '/sign-in');
    } else {
      print('Error during verify forgot password');
    }
  }
}
