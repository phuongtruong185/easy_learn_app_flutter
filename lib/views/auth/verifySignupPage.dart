import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_learn_app/controllers/verifySignupController.dart';
import 'package:easy_learn_app/widget/bezierContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifySignupPage extends StatefulWidget {
  VerifySignupPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _VerifySignupPage createState() => _VerifySignupPage();
}

class _VerifySignupPage extends State<VerifySignupPage> {
  final VerifySignupController verifySignupController =
      Get.put(VerifySignupController());
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  void _verifySignUp(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String first_name = _firstNameController.text.trim();
    String last_name = _lastNameController.text.trim();
    String password = _passwordController.text.trim();
    String otp = _otpController.text.trim();
    String? email = prefs.getString('email');
    String? phone = prefs.getString('phone');

    if (first_name.isEmpty ||
        last_name.isEmpty ||
        password.isEmpty ||
        otp.isEmpty) {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Lỗi!',
          message: 'Vui lòng nhập đầy đủ thông tin đăng nhập',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      verifySignupController.verifySignup(
          first_name, last_name, password, otp, email!, phone!, context);
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

  Widget _entryField(String title,
      {bool isPassword = false, TextEditingController? controller}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color(0xFF4C53A5)),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              obscureText: isPassword,
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
          child: verifySignupController.isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : TextButton(
                  onPressed: () {
                    _verifySignUp(context);
                  },
                  child: const Text(
                    'Đăng Ký',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
        ));
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/sign-in');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Đã có tài khoản?',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Đăng Nhập',
              style: TextStyle(
                  color: Color(0xFF4C53A5),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
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
        'Đăng Ký',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4C53A5),
        ),
      ),
    );
  }

  Widget _fieldWidget() {
    return Column(
      children: <Widget>[
        _entryField("Tên", controller: _firstNameController),
        _entryField("Họ", controller: _lastNameController),
        _entryField("Mật khẩu",
            isPassword: true, controller: _passwordController),
        _entryField("OTP", controller: _otpController),
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
                    _fieldWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    const SizedBox(height: 20),
                    _loginAccountLabel(),
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
