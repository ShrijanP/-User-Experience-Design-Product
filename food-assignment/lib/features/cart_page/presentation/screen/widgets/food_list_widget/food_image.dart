import 'package:flutter/material.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';

import '../../../../../shared/utils/config.dart';
import '../../../../../shared/constants/size_config.dart';

class FoodImage extends StatefulWidget {
  String foodImage;
  FoodImage({required this.foodImage});

  @override
  _FoodImageState createState() => _FoodImageState();
}

class _FoodImageState extends State<FoodImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      child: AspectRatio(
        aspectRatio: 0.88,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F9),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Image.network(
              "${AppConfigs.imageUrl}${widget.foodImage.toString()}"),
          // Image.network("assets/images/Profile Image.png"),
        ),
      ),
    );
    //   Container(
    //   height: SizeConfig.screenHeight!/8.54,                 /// 80.0
    //   width: SizeConfig.screenWidth!/4.57,                   /// 90.0
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //       image: Image.network("${AppConfigs.imageUrl}${widget.foodImage.toString()}"),
    //       // AssetImage(
    //       //     "${widget.foodImage}"
    //       // ),
    //       fit: BoxFit.cover,
    //     ),
    //     borderRadius: BorderRadius.circular(20.0),
    //   ),
    // );
  }
}
