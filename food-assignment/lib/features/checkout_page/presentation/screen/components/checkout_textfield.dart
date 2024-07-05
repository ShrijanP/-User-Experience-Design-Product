import 'package:flutter/material.dart';

import '../../../../home_page/presentation/screen/components/colors.dart';
import '../../../../shared/constants/size_config.dart';

class CheckoutTextField extends StatefulWidget {
  String enter_text;
  double size_width;
  TextEditingController controller;
  CheckoutTextField(
      {required this.enter_text,
      required this.size_width,
      required this.controller});

  @override
  _CheckoutTextFieldState createState() => _CheckoutTextFieldState();
}

class _CheckoutTextFieldState extends State<CheckoutTextField> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(SizeConfig.screenWidth! / 41.1, 0,
          SizeConfig.screenWidth! / 82.2, SizeConfig.screenHeight! / 85.37),
      child: Container(
        width: SizeConfig.screenWidth! / widget.size_width,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        child: TextField(
          controller: widget.controller,
          style: const TextStyle(color: Colors.black),
          cursorColor: Colors.black,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(width: 1, color: Colors.transparent),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: widget.enter_text,
            hintStyle: const TextStyle(color: Colors.black26),
          ),
        ),
      ),
    );
  }
}
