import 'package:flutter/material.dart';

class CheckoutItem extends StatefulWidget {
  @override
  _CheckoutItemState createState() => _CheckoutItemState();
}

class _CheckoutItemState extends State<CheckoutItem> {
  int? _paymentOption =
      0; // 0 represents PayPal, 1 represents other payment option
  bool _isVisaEnabled = false; // Track the enabled state of Visa payment option
  bool _isMastercardEnabled =
      false; // Track the enabled state of Mastercard payment option

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Phương thức Thanh Toán',
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Color(0xFF4C53A5),
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Container(
            height: 110,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Radio<int?>(
                      value: 0,
                      groupValue: _paymentOption,
                      onChanged: (int? value) {
                        setState(() {
                          _paymentOption = value;
                          _isVisaEnabled = false;
                          _isMastercardEnabled = false;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                    const Image(
                      image: AssetImage('lib/assets/images/paypal.png'),
                      width: 120,
                    ),
                  ],
                ) // Add other widgets related to the checkout item here
              ],
            ),
          ),
          Container(
            height: 110,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Radio<int?>(
                      value: 1,
                      groupValue: _paymentOption,
                      onChanged: !_isVisaEnabled
                          ? (int? value) {
                              setState(() {
                                _paymentOption = value;
                                _isVisaEnabled =
                                    true; // Enable Visa payment option
                                _isMastercardEnabled =
                                    false; // Disable Mastercard payment option
                              });
                            }
                          : null,
                    ),
                    const SizedBox(width: 10),
                    const Image(
                      image: AssetImage('lib/assets/images/visa.png'),
                      width: 100,
                      height: 90,
                    ),
                  ],
                ) // Add other widgets related to the checkout item here
              ],
            ),
          ),
          Container(
            height: 110,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Radio<int?>(
                      value: 2,
                      groupValue: _paymentOption,
                      onChanged: !_isMastercardEnabled
                          ? (int? value) {
                              setState(() {
                                _paymentOption = value;
                                _isVisaEnabled =
                                    false; // Enable Visa payment option
                                _isMastercardEnabled =
                                    true; // Disable Mastercard payment option
                              });
                            }
                          : null,
                    ),
                    const SizedBox(width: 10),
                    const Image(
                      image: AssetImage('lib/assets/images/mastercard.png'),
                      width: 100,
                    ),
                  ],
                ) // Add other widgets related to the checkout item here
              ],
            ),
          ),
        ],
      ),
    );
  }
}
