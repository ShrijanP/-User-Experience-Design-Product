import 'package:flutter/material.dart';

import '../../shared/constants/size_config.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';

class RouterText extends StatelessWidget {
  const RouterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.screenHeight!/85.38, bottom: SizeConfig.screenHeight!/85.38),  /// 8.0-8.0
      child: Text("Successfully completed!", style: TextStyle(color: Colors.black54, fontSize: SizeConfig.screenHeight!/27.32)),   /// 25
    );
  }
}
