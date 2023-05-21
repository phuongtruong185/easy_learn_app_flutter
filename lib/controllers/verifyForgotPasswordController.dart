import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/verifyForgotPassword_model.dart';


class VerifyForgotPasswordController extends GetxController {
  var isLoading = false.obs;

  Future<void> verifyForgotPassword(String email, String otp, String password, context) async {
    var formData = VerifyForgotPassword(email, otp, password);
    isLoading(true);
    var response = await API.post('/auth/verifyOtpForgotPassword',
        body: formData.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });
    isLoading(false);
    if (response['message'] == 'Đặt lại mật khẩu thành công') {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Success!',
          message: 'Đặt lại mật khẩu thành công',
          contentType: ContentType.success,
          inMaterialBanner: true,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushNamed(context, '/sign-in');
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
