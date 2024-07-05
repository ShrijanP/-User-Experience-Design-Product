import 'package:flutter/material.dart';
import 'package:food_assignment/features/shared/domain/models/product/product_model.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';
import '../../../../shared/constants/size_config.dart';

class FoodDescription extends StatelessWidget {
  final Product food;
  const FoodDescription({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.screenHeight! / 45.54),
      child: Container(
        child: Text(
          food.description,
          style: const TextStyle(color: Colors.black38),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
