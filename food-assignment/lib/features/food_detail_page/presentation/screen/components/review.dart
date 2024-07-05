import 'package:flutter/material.dart';
import 'package:food_assignment/features/shared/domain/models/product/product_model.dart';
// import 'package:food_assignment/features/home_page/components/colors.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';
import '../../../../home_page/presentation/screen/components/colors.dart';
import '../../../../shared/constants/size_config.dart';

class ReviewStars extends StatefulWidget {
  final Product food;
  const ReviewStars({super.key, required this.food});

  @override
  _ReviewStarsState createState() => _ReviewStarsState();
}

class _ReviewStarsState extends State<ReviewStars> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.screenHeight! / 45.54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.star_rounded,
                color: textColor,
              ),
              Text(
                widget.food.rating.toString(),
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.screenHeight! / 45.54),
              ),
              Padding(
                padding: EdgeInsets.only(left: SizeConfig.screenWidth! / 51.38),
                child: const Text("(52+ Reviews)",
                    style: TextStyle(color: Color.fromARGB(66, 0, 0, 0))),
              )
            ],
          ),
          Container(
            height: SizeConfig.screenHeight! / 34.15,
            width: SizeConfig.screenWidth! / 137,
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ),
    );
  }
}
