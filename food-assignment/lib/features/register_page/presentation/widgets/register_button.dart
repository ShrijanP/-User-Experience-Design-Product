import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:food_assignment/featuresatures/home_page/components/colors.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';
// import 'package:food_assignment/features/login_page/presentation/login_page_view.dart';

import '../../../home_page/presentation/screen/components/colors.dart';
import '../../../login_page/presentation/providers/auth_providers.dart';
import '../../../login_page/presentation/providers/state/auth_state.dart';
import '../../../login_page/presentation/screen/login_page_view.dart';
import '../../../shared/constants/size_config.dart';
import '../../../shared/widgets/overlay_notification.dart';

class RegisterButton extends ConsumerStatefulWidget {
  final TextEditingController firstEditingController;
  final TextEditingController lastEditingController;
  final TextEditingController emailEditingController;
  final TextEditingController passwordEditingController;
  final TextEditingController confirmPassword;
  final TextEditingController addressEditingController;
  final TextEditingController contactEditingController;
  const RegisterButton(
      {Key? key,
      required this.emailEditingController,
      required this.firstEditingController,
      required this.lastEditingController,
      required this.passwordEditingController,
        required this.addressEditingController,
        required this.contactEditingController,
      required this.confirmPassword})
      : super(key: key);

  @override
  ConsumerState createState() => _RegisterButtonState();
}

class _RegisterButtonState extends ConsumerState<RegisterButton> {
  @override
  Widget build(BuildContext context) {


    final state = ref.watch(registrationStateNotifierProvider);
    ref.listen(
      registrationStateNotifierProvider.select((value) => value),
      ((previous, next) {
        if (next is Failure) {
          showTopOverlayNotificationError(title: next.exception.message.toString());
        } else if (next is Success) {
          Navigator.pop(context);
        }
      }),
    );


    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.screenWidth! / 20.55,
          SizeConfig.screenHeight! / 17.075,
          SizeConfig.screenWidth! / 20.55,
          SizeConfig.screenHeight! / 45.54),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.0, 1.0],
            colors: [
              buttonColor,
              lightColor,
            ],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            minimumSize: MaterialStateProperty.all(Size(
                SizeConfig.screenWidth! / 1.37,
                SizeConfig.screenHeight! / 13.66)),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          onPressed: () {
            Map<String, dynamic> data = {
              "firstname": widget.firstEditingController.text,
              "lastname": widget.lastEditingController.text,
              "email": widget.emailEditingController.text,
              "password": widget.passwordEditingController.text,
              "contact": widget.contactEditingController.text,
              "address": widget.addressEditingController.text,
            };

            print("USER DATA::${data}");

            // KeyboardUtil.hideKeyboard(context);
            ref
                .read(registrationStateNotifierProvider.notifier)
                .registerUser(data: data);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => LoginPageView()));
          },
          child: Text(
            "SIGNUP",
            style: TextStyle(
              fontSize: SizeConfig.screenHeight! / 42.68,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),

            /// 16
          ),
        ),
      ),
    );
  }
}
