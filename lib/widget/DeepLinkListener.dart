import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

class DeepLinkListener extends StatefulWidget {
  const DeepLinkListener({Key? key}) : super(key: key);

  @override
  _DeepLinkListenerState createState() => _DeepLinkListenerState();
}

class _DeepLinkListenerState extends State<DeepLinkListener> {
  @override
  void initState() {
    super.initState();

// This is the code that will be executed when the app is opened from a deep link
    //
    Linkify(
      onOpen: (link) async {
        // if link open OrderHistoryPage
        if (link.url != null) {
          Get.toNamed('/order-history');
        }
        else {
          Get.toNamed('/home');
        }
      },
      text: "https://easy-learn-app.herokuapp.com/order-history",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
