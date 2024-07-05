import 'package:flutter/material.dart';

import '../components/checkbox_save.dart';
import '../components/checkout_textfield.dart';
import '../components/page_name.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PageName(text_name: "Card Holder Name"),
          // CheckoutTextField(enter_text: "Your card holder name", size_width: 1.18,),   //350
          // PageName(text_name: "Card Number"),
          // CheckoutTextField(enter_text: "Your card number", size_width: 1.18,),
          //
        ],
      ),
    );
  }
}
