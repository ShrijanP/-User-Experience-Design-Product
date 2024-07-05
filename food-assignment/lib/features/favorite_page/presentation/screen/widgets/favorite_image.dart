import 'package:flutter/material.dart';

import '../../../../home_page/presentation/screen/components/colors.dart';
import '../../../../shared/constants/size_config.dart';
import '../../../../shared/utils/config.dart';

class FavoriteDetail extends StatefulWidget {
  String food_image_name;
  String food_name;
  String food_category;
  String food_price;

  FavoriteDetail(
      {required this.food_image_name,
      required this.food_name,
      required this.food_category,
      required this.food_price});

  @override
  _FavoriteDetailState createState() => _FavoriteDetailState();
}

class _FavoriteDetailState extends State<FavoriteDetail> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: SizeConfig.screenHeight! / 6.21,
          width: SizeConfig.screenWidth! / 2.055,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(AppConfigs.imageUrl + widget.food_image_name),
              fit: BoxFit.cover,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.food_name.toString(),
                maxLines: 1,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: SizeConfig.screenHeight! / 50.15,
                    fontWeight: FontWeight.w700),
              ),
              // Text(
              //   widget.food_category,
              //   style: TextStyle(
              //       color: Colors.black38,
              //       fontSize: SizeConfig.screenHeight! / 55.69,
              //       fontWeight: FontWeight.w400),
              // ),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.screenHeight! / 136.6),
                child: Text(
                  "Rs. ${widget.food_price}",
                  style: TextStyle(
                      color: buttonColor,
                      fontSize: SizeConfig.screenHeight! / 60.95,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
