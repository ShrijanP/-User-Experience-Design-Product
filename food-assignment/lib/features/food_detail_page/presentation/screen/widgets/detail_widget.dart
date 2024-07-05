import 'package:flutter/material.dart';
import 'package:food_assignment/configuration/food.dart';
import 'package:food_assignment/features/food_detail_page/presentation/screen/components/features_food.dart';
import 'package:food_assignment/features/shared/domain/models/product/product_model.dart';
// import 'package:food_assignment/features/food_detail_page/widgets/addtocart_button.dart';
// import 'package:food_assignment/features/food_detail_page/components/features_food.dart';
// import 'package:food_assignment/features/food_detail_page/components/review.dart';
// import 'package:food_assignment/features/food_detail_page/widgets/food_description.dart';
// import 'package:food_assignment/features/food_detail_page/widgets/increase_decrease_button.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';
import '../../../../review/presentation/screens/review_product.dart';
import '../../../../shared/constants/size_config.dart';
import '../components/review.dart';
import 'addtocart_button.dart';
import 'food_description.dart';
import 'food_name.dart';
import 'increase_decrease_button.dart';

class DetailWidget extends StatefulWidget {
  final Product food;
  const DetailWidget({super.key, required this.food});

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.only(top: SizeConfig.screenHeight! * 0.35),
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 10, offset: Offset(0, -1))
          ]),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: SizeConfig.screenWidth! / 3.43,
                height: SizeConfig.screenHeight! / 227.67,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black12),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! / 34.15,
              ),
              FoodName(food: widget.food),
              ReviewStars(food: widget.food),
              FoodDescription(food: widget.food),
              FeaturesFood(food: widget.food),
              IncreaseDecrease(food: widget.food),
              // const AddToCartButton(),
              ReviewProduct(
                rating: widget.food.rating.toDouble(),
                productId: widget.food.id.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
