
import 'package:easy_learn_app/widget/bezierContainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_learn_app/controllers/otpForgotPasswordController.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final OTPForgotPasswordController otpForgotPasswordController = Get.put(OTPForgotPasswordController());
  final TextEditingController _emailController = TextEditingController();

  void _signUp(context) {
    String email = _emailController.text.trim();
    if (email.isEmpty ) {
      Get.snackbar('Error', 'Please enter email');
    } else {
      otpForgotPasswordController.otpForgotPassword(email, context);
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
              child: const Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            const Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
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
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: otpForgotPasswordController.isLoading.value
              ? const CircularProgressIndicator(
            color: Colors.white,
          )
              : TextButton(
            onPressed: () {
              _signUp(context);
            },
            child: const Text(
              'Next',
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
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
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
        'Forgot Password',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color(0xFFFFAA2C),
        ),
      ),
    );
  }

  Widget _emailWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email", controller: _emailController),
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
                    _emailWidget(),
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
