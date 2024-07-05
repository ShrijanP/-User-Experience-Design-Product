import 'package:flutter/material.dart';

import '../../../../../home_page/presentation/screen/components/colors.dart';
import '../../../../../shared/constants/size_config.dart';
// import 'package:food_assignment/features/home_page/components/colors.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';

class FoodText extends StatefulWidget {
  String foodName;
  String foodPrice;
  String quantity;
  FoodText({super.key, required this.foodName, required this.foodPrice, required this.quantity});

  @override
  _FoodTextState createState() => _FoodTextState();
}

class _FoodTextState extends State<FoodText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.foodName,
          style: TextStyle(
              color: Colors.black, fontSize: SizeConfig.screenHeight! / 55.69),
          maxLines: 1,
        ),
        SizedBox(height: SizeConfig.screenHeight! / 341.5),
        Text.rich(
          TextSpan(
            text: "\Rs.${widget.foodPrice}",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: buttonColor,
                fontSize: SizeConfig.screenHeight! / 48.95),
            children: [
              TextSpan(
                  text: " x ${widget.quantity}", style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ],
    );
  }
}
