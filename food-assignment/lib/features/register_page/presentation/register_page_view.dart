import 'package:flutter/material.dart';
import 'package:food_assignment/features/register_page/presentation/widgets/background_image.dart';
import 'package:food_assignment/features/register_page/presentation/widgets/text_signin.dart';
// import 'package:food_assignment/features/register_page/widgets/background_image.dart';
// import 'package:food_assignment/features/register_page/widgets/text_signin.dart';
import 'widgets/register_button.dart';
import 'widgets/text_field.dart';

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({Key? key}) : super(key: key);

  @override
  _RegisterPageViewState createState() => _RegisterPageViewState();
}

class _RegisterPageViewState extends State<RegisterPageView> {
  final TextEditingController _firstEditingController = TextEditingController();
  final TextEditingController _lastEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController addressEditingController =
      TextEditingController();
  final TextEditingController contactEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BackgroundImage(),
                RegisterTextField(
                  firstEditingController: _firstEditingController,
                  lastEditingController: _lastEditingController,
                  emailEditingController: _emailEditingController,
                  passwordEditingController: _passwordEditingController,
                  confirmPassword: confirmPassword,
                  addressEditingController: addressEditingController,
                  contactEditingController: contactEditingController,
                ),
                RegisterButton(
                  firstEditingController: _firstEditingController,
                  lastEditingController: _lastEditingController,
                  emailEditingController: _emailEditingController,
                  passwordEditingController: _passwordEditingController,
                  confirmPassword: confirmPassword,
                  addressEditingController: addressEditingController,
                  contactEditingController: contactEditingController,
                ),
                TextSignIn()
              ],
            ),
          ),
        ));
  }
}
