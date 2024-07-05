import 'package:flutter/material.dart';

import '../components/checkbox_save.dart';
import '../components/checkout_textfield.dart';
import '../components/page_name.dart';
// import 'package:food_assignment/features/checkout_page/components/checkbox_save.dart';
// import 'package:food_assignment/features/checkout_page/components/checkout_textfield.dart';
// import 'package:food_assignment/features/checkout_page/components/page_name.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageName(text_name: "Full Name"),
          // CheckoutTextField(
          //   enter_text: "Enter your full name",
          //   size_width: 1.18,
          // ),
          PageName(text_name: "Phone"),
          // CheckoutTextField(
          //   enter_text: "Enter your phone number",
          //   size_width: 1.18,
          // ),
          PageName(text_name: "Address"),
          // CheckoutTextField(
          //   enter_text: "Type your home address",
          //   size_width: 1.18,
          // ),
        ],
      ),
    );
  }
}
