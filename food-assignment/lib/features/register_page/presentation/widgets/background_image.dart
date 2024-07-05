import 'package:flutter/material.dart';

import '../../../login_page/presentation/screen/widgets/text_title.dart';
import '../../../shared/constants/size_config.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';
// import 'package:food_assignment/features/login_page/presentation/widgets/text_title.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: SizeConfig.screenHeight! / 5,

            /// 160.0
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/main/background_image.png'),
                    fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: TextTitle(title: "' ENROLL  AMIGOS '"),
                ),
              ],
            ),
          )
        ],
      ),
    );
    ;
  }
}
