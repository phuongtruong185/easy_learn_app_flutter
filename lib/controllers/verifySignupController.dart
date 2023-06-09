import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:get/get.dart';
import '../models/verifySignup_model.dart';
import 'package:flutter/material.dart';

class VerifySignupController extends GetxController {
  var isLoading = false.obs;

  Future<void> verifySignup(String first_name, String last_name,
      String password, String otp, String email, String phone, context) async {
    var formData =
        VerifySignup(first_name, last_name, password, otp, email, phone);
    isLoading(true);
    var response = await API.post('/auth/verifyOtp',
        body: formData.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        });
    isLoading(false);
    if(response['message'] == 'Đăng kí thành công!'){
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Success!',
          message: 'Đăng ký thành công',
          contentType: ContentType.success,
          inMaterialBanner: true,
        ),
      );
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
