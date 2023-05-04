import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../../controllers/changePassController.dart';
import 'package:get/get.dart';

import '../../widget/AppBarCustome.dart';

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({super.key});

  @override
  _ChangePassPageState createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  final ChangePassController changePassController =
      Get.put(ChangePassController());
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();

  void _changePass(context) async {
    String password = _passwordController.text.trim();
    String newpassword = _newpasswordController.text.trim();
    if (password.isEmpty || newpassword.isEmpty) {
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
      changePassController.changePass(password, newpassword, context);
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
          child: changePassController.isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : TextButton(
                  onPressed: () {
                    _changePass(context);
                  },
                  child: const Text(
                    'Đổi mật khẩu',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
        ));
  }

  Widget _PasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Mật khẩu",
            isPassword: true, controller: _passwordController),
        _entryField("Mật khẩu mới",
            isPassword: true, controller: _newpasswordController),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: ListView(
            children: <Widget>[
              AppBarCustome(name: 'Đổi Mật Khẩu'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _PasswordWidget(),
                      const SizedBox(height: 20),
                      _submitButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),

        bottomNavigationBar: CurvedNavigationBar(
          onTap: (index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/myOrder');
            } else if (index == 2) {
              Navigator.pushNamed(context, '/wishList');
            } else if (index == 3) {
              Navigator.pushNamed(context, '/profile');
            } else {
              Navigator.pushNamed(context, '/home');
            }
          },
          backgroundColor: Colors.transparent,
          color: const Color(0xFF4C53A5),
          height: 70,
          items: const [
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.book_outlined,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.favorite,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
          ],
          animationDuration: const Duration(milliseconds: 200),
          index: 3,
        ));
  }
}
