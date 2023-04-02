import 'package:easy_learn_app/views/auth/forgotPasswordPage.dart';
import 'package:easy_learn_app/views/auth/loginPage.dart';
import 'package:easy_learn_app/views/auth/signupPage.dart';
import 'package:easy_learn_app/views/auth/verifyForgotPasswordPage.dart';
import 'package:easy_learn_app/views/auth/verifySignupPage.dart';
import 'package:easy_learn_app/views/homePage/homePage.dart';
import 'package:easy_learn_app/views/cartPage/cartPage.dart';
import 'package:easy_learn_app/views/itemPage/itemPage.dart';
import 'package:easy_learn_app/views/profilePage/profilePage.dart';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const GetMaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? access_token = prefs.getString('access_token');
    if (access_token != null) {
      return true;
    } else {
      return false;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Learn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FutureBuilder(
        future: isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              return const HomePage();
            } else {
              return const LoginPage();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(builder: (context) => const HomePage());
            break;
          case '/sign-in':
            return MaterialPageRoute(builder: (context) => LoginPage());
            break;
          case '/sign-up':
            return MaterialPageRoute(builder: (context) => SignUpPage());
            break;
          case '/verify-sign-up':
            return MaterialPageRoute(builder: (context) => VerifySignupPage());
            break;
          case '/forgot-password':
            return MaterialPageRoute(
                builder: (context) => ForgotPasswordPage());
            break;
          case '/verify-forgot-password':
            return MaterialPageRoute(
                builder: (context) => VerifyForgotPasswordPage());
            break;
          case '/cartPage':
            return MaterialPageRoute(builder: (context) => CartPage());
            break;
          case '/itemPage':
            return MaterialPageRoute(
                builder: (context) => ItemPage(
                      course: null,
                    ));
            break;
          case '/profile':
            return MaterialPageRoute(builder: (context) => ProfilePage());
            break;
          default:
            return MaterialPageRoute(builder: (context) => HomePage());
        }
      },
    );
  }
}
