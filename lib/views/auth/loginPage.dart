import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_learn_app/widget/bezierContainer.dart';
import 'package:flutter/material.dart';
import '../../controllers/loginController.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = Get.put(LoginController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(context) async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Lỗi!',
          message:
          'Vui lòng nhập đầy đủ thông tin đăng nhập',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      loginController.login(email, password, context);
    }
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF4C53A5)),
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
          child: loginController.isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : TextButton(
                  onPressed: () {
                    _login(context);

                  },
                  child: const Text(
                    'Đăng Nhập',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
        ));
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/sign-up');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Chưa có tài khoản?',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Đăng Ký',
              style: TextStyle(
                  color: Color(0xFF4C53A5),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _forgotPasswordLabel() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/forgot-password');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              'Quên mật khẩu?',
              style: TextStyle(
                  color: Color(0xFF4C53A5),
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
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
        'Đăng Nhập',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4C53A5),
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email", controller: _emailController),
        _entryField("Mật khẩu",
            isPassword: true, controller: _passwordController),
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
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: const BezierContainer()),
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
                  const SizedBox(height: 50),
                  _emailPasswordWidget(),
                  const SizedBox(height: 20),
                  _submitButton(),
                  _forgotPasswordLabel(),
                  const SizedBox(height: 20),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
