import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../models/changePass_model.dart';

class ChangePassController extends GetxController {
  var isLoading = false.obs;

  Future<void> changePass(String password, String newpassword, context) async {
    var prefs = await SharedPreferences.getInstance();
    String access_token = prefs.getString('access_token')!;
    access_token = access_token.replaceAll('"', '');

    var formData = ChangePass(password, newpassword);
    isLoading(true);
    var response = await API.patch('/auth/changePassword',
        body: formData.toJson(),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $access_token'
        });
    isLoading(false);
    print(response);
    if (response['message'] == 'Cập nhật thành công!') {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Success!',
          message: 'Đổi mật khẩu thành công',
          contentType: ContentType.success,
          inMaterialBanner: true,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
