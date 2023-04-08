import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../widget/ProfilePageAppBar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            const ProfilePageAppBar(),
            Container(
              padding: const EdgeInsets.only(top: 15),
              decoration: const BoxDecoration(
                  color: Color(0xFFEDECF2),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35))),
              //height full screen
              height: MediaQuery.of(context).size.height - 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 5, color: Colors.white),
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Nguyễn Văn A',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'nguyenvana@gmail.com',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 30,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Địa chỉ: 123 Đường ABC, Quận XYZ, TP HCM',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        // Hành động khi nút được nhấn
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        minimumSize: const Size(double.infinity, 50),
                        primary: const Color(0xFF4C53A5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Sửa Thông Tin',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          SharedPreferences.getInstance().then((prefs) {
                            prefs.remove('access_token');
                            var snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                title: 'Success!',
                                message: 'Đăng xuất thành công',
                                contentType: ContentType.success,
                                inMaterialBanner: true,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            Navigator.pushNamed(context, '/sign-in');
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          minimumSize: const Size(double.infinity, 50),
                          primary: const Color(0xFF4C53A5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Đăng Xuất',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold)),
                      )),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          onTap: (index) {
            if (index == 1) {
              Navigator.pushNamed(context, '/wishList');
            } else if (index == 2) {
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
          index: 2,
        ));
  }
}
