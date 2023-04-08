import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_learn_app/widget/bezierContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/verifyForgotPasswordController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyForgotPasswordPage extends StatefulWidget {
  VerifyForgotPasswordPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _VerifyForgotPasswordPageState createState() =>
      _VerifyForgotPasswordPageState();
}

class _VerifyForgotPasswordPageState extends State<VerifyForgotPasswordPage> {
  final VerifyForgotPasswordController verifyForgotPasswordController =
      Get.put(VerifyForgotPasswordController());
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _verifyForgotPassWord(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString('emailForgotPass')!;
    String otp = _otpController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || otp.isEmpty || password.isEmpty) {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Lỗi!',
          message: 'Vui lòng nhập đầy đủ thông tin',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      verifyForgotPasswordController.verifyForgotPassword(
          email, otp, password, context);
    }
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Color(0xFF4C53A5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, {TextEditingController? controller}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Obx(() => Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xff444A94), Color(0xFF4C53A5)])),
          child: verifyForgotPasswordController.isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : TextButton(
                  onPressed: () {
                    _verifyForgotPassWord(context);
                  },
                  child: const Text(
                    'Đổi Mật Khẩu',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
        ));
  }

  Widget _logo() {
    return const Align(
      alignment: Alignment.center,
      child: Image(
        image: AssetImage('lib/assets/images/logo.png'),
        height: 200,
        width: 200,
      ),
    );
  }

  Widget _title() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        'Quên Mật Khẩu',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4C53A5),
        ),
      ),
    );
  }

  Widget _emailWidget() {
    return Column(
      children: <Widget>[
        _entryField("OTP", controller: _otpController),
        _entryField("Mật khẩu mới", controller: _passwordController),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _logo(),
                    _title(),
                    const SizedBox(
                      height: 50,
                    ),
                    _emailWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
