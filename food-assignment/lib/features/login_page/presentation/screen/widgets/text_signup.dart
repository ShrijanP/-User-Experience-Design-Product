import 'package:flutter/material.dart';
// import 'package:food_assignment/features/home_pagee_page/components/colors.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';
// import 'package:food_assignment/features/register_page/register_page_view.dart';

import '../../../../home_page/presentation/screen/components/colors.dart';
import '../../../../register_page/presentation/register_page_view.dart';
import '../../../../shared/constants/size_config.dart';

class TextSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.screenWidth!/20.55,
          SizeConfig.screenHeight!/136.6,
          SizeConfig.screenWidth!/20.55,
          0
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an account?", style: TextStyle(color: texthint),),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPageView()));
              },
              child: Text(
                " Sign up",
                style: TextStyle(
                    color: buttonColor,
                    fontWeight: FontWeight.w600,
                    fontSize: SizeConfig.screenHeight!/45.54          /// 15
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
