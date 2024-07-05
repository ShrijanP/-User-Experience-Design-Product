import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../../../checkout_page/presentation/screen/checkout_page_view.dart';
import '../../../../../home_page/presentation/screen/components/colors.dart';
import '../../../../../shared/constants/size_config.dart';

class CheckoutButton extends StatefulWidget {
  final String cartId;
  final String amount;
  const CheckoutButton({Key? key, required this.cartId, required this.amount})
      : super(key: key);

  @override
  _CheckoutButtonState createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CheckoutPageView(
                cartId: widget.cartId,
                amount: widget.amount,
              )));
      },
      child: Container(
          width: SizeConfig.screenWidth! / 1.02,
          height: SizeConfig.screenHeight! / 17.42,
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(30)),
          child: Center(
              child: Text(
            "Checkout",
            style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.screenHeight! / 45.15,
                fontWeight: FontWeight.bold),
          ))),
    );
  }
}
