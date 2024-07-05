import 'package:flutter/material.dart';

import '../../../../home_page/presentation/screen/components/colors.dart';
import '../../../../shared/constants/size_config.dart';
// import 'package:food_assignment/features/home_page/components/colors.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: SizeConfig.screenWidth!/15.3),
      child: Container(
        alignment: Alignment.centerRight,
        child: Text("Forgot Password?" , style: TextStyle(color: textColor),),
      ),
    );
  }
}
