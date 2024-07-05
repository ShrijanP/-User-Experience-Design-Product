import 'package:flutter/material.dart';

import '../../../home_page/presentation/screen/components/colors.dart';
import '../../../login_page/presentation/screen/widgets/text_field_widget/text_field_input.dart';
import '../../../login_page/presentation/screen/widgets/text_field_widget/text_field_password.dart';
import '../../../shared/constants/size_config.dart';
// import 'package:food_assignment/features/login_page/login_pagelogin_pagepresentation/widgets/text_field_widget/text_field_input.dart';
// import 'package:food_assignment/features/login_page/presentation/widgets/text_field_widget/text_field_password.dart';

class RegisterTextField extends StatefulWidget {
  final TextEditingController firstEditingController;
  final TextEditingController lastEditingController;
  final TextEditingController emailEditingController;
  final TextEditingController passwordEditingController;
  final TextEditingController confirmPassword;
  final TextEditingController addressEditingController;
  final TextEditingController contactEditingController;
  const RegisterTextField(
      {Key? key,
      required this.emailEditingController,
      required this.firstEditingController,
      required this.lastEditingController,
      required this.addressEditingController,
      required this.contactEditingController,
      required this.passwordEditingController,
      required this.confirmPassword})
      : super(key: key);

  @override
  _RegisterTextFieldState createState() => _RegisterTextFieldState();
}

class _RegisterTextFieldState extends State<RegisterTextField> {
  bool passwordObscure = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          TextFieldInput(
            text: "Full name",
            iconName: Icons.account_circle,
            ltext: "Full Name",
            controller: widget.firstEditingController,
          ),
          // TextFieldInput(
          //   text: "last name",
          //   iconName: Icons.account_circle,
          //   ltext: "Last Name",
          //   controller: widget.lastEditingController,
          // ),
          TextFieldInput(
            text: "email",
            iconName: Icons.mail,
            ltext: "Email",
            controller: widget.emailEditingController,
          ),
          TextFieldInput(
            text: "contact",
            iconName: Icons.phone_android,
            ltext: "Contact",
            controller: widget.contactEditingController,
          ),
          // TextFieldInput(
          //   text: "address",
          //   iconName: Icons.pin_drop,
          //   ltext: "Address",
          //   controller: widget.addressEditingController,
          // ),
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.screenWidth! / 20.55,
                  SizeConfig.screenHeight! / 68.3,
                  SizeConfig.screenWidth! / 20.55,
                  SizeConfig.screenHeight! / 34.15),
              child: TextField(
                obscureText: passwordObscure,
                controller: widget.passwordEditingController,
                style: TextStyle(color: textColor),
                cursorColor: textColor,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.vpn_key),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordObscure = !passwordObscure;
                        });
                      },
                      icon: Icon(passwordObscure
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                          width: SizeConfig.screenWidth! / 205.5,
                          color: textColor),

                      /// 2
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: texthint),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: "password",
                    hintStyle: TextStyle(color: texthint.withOpacity(0.3)),
                    labelText: "Password",
                    labelStyle: TextStyle(color: texthint.withOpacity(0.6))),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  SizeConfig.screenWidth! / 20.55,
                  SizeConfig.screenHeight! / 68.3,
                  SizeConfig.screenWidth! / 20.55,
                  SizeConfig.screenHeight! / 34.15),
              child: TextField(
                controller: widget.confirmPassword,
                obscureText: passwordObscure,
                style: TextStyle(color: textColor),
                cursorColor: textColor,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.vpn_key),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordObscure = !passwordObscure;
                        });
                      },
                      icon: Icon(passwordObscure
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(
                          width: SizeConfig.screenWidth! / 205.5,
                          color: textColor),

                      /// 2
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: texthint),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: "password",
                    hintStyle: TextStyle(color: texthint.withOpacity(0.3)),
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(color: texthint.withOpacity(0.6))),
              ),
            ),
          ),
          // TextFieldPassword(),
          // TextFieldPassword(),
        ]));
  }
}
