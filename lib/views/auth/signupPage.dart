import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:easy_learn_app/controllers/signupController.dart';
import 'package:easy_learn_app/widget/bezierContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignupController signupController = Get.put(SignupController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _signUp(context) {
    String email = _emailController.text.trim();
    String phone = _phoneController.text.trim();
    if (email.isEmpty || phone.isEmpty) {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Lỗi!',
          message:
          'Vui lòng nhập đầy đủ thông tin đăng ký',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      signupController.signUp(email, phone, context);
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xff444A94)),
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
    return Obx(() =>
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
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
                  colors: [Color(0xff444A94),Color(0xFF4C53A5)])),
          child: signupController.isLoading.value
              ? const CircularProgressIndicator(
            color: Colors.white,
          )
              : TextButton(
            onPressed: () {
              _signUp(context);
            },
            child: const Text(
              'Tiếp Tục',
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
              'Đăng nhập',
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

  Widget _emailPhoneWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email", controller: _emailController),
        _entryField("Số điện thoại", controller: _phoneController),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery
                  .of(context)
                  .size
                  .height * .15,
              right: -MediaQuery
                  .of(context)
                  .size
                  .width * .4,
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
                    _emailPhoneWidget(),
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
