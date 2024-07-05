import 'package:flutter/material.dart';

import '../../../../shared/constants/size_config.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({Key? key}) : super(key: key);

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: SizeConfig.screenHeight!/56.92,
      right: SizeConfig.screenWidth!/34.25,
      child: const Icon(
        Icons.favorite,
        color: Color.fromARGB(255, 4, 3, 3),
      )
    );
  }
}
