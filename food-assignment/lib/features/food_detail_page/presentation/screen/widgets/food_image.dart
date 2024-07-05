import 'package:flutter/material.dart';
import 'package:food_assignment/features/shared/domain/models/product/product_model.dart';
import '../../../../shared/utils/config.dart';
import '../../../../shared/constants/size_config.dart';
import '../components/arrow_back.dart';
import '../components/favorite_food.dart';

class FoodImage extends StatefulWidget {
  Product food;
  FoodImage({required this.food});

  @override
  _FoodImageState createState() => _FoodImageState();
}

class _FoodImageState extends State<FoodImage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      height: SizeConfig.screenHeight! * 0.45,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: NetworkImage(
            "${AppConfigs.imageUrl}${widget.food.images.first}", // Assuming foodImageName contains the image path or URL
          ),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! / 13.7,
            vertical: SizeConfig.screenHeight! / 34.15,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ArrowBack(),
              FavoriteFood(
                productId: widget.food.id.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
