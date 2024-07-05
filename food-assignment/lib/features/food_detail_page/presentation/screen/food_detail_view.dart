import 'package:flutter/material.dart';
import 'package:food_assignment/configuration/food.dart';
import 'package:food_assignment/features/food_detail_page/presentation/screen/widgets/detail_widget.dart';
import 'package:food_assignment/features/food_detail_page/presentation/screen/widgets/food_image.dart';
import 'package:food_assignment/features/shared/domain/models/product/product_model.dart';
// import 'package:food_assignment/features/food_detail_page/widgets/detail_widget.dart';
// import 'package:food_assignment/features/food_detail_page/widgets/food_image.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';
// import '../../../../shared/constants/size_config.dart';
import '../../../shared/constants/size_config.dart';

class FoodDetailView extends StatefulWidget {
  Product food;
  FoodDetailView({required this.food});

  @override
  _FoodDetailViewState createState() => _FoodDetailViewState();
}

class _FoodDetailViewState extends State<FoodDetailView> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            FoodImage(food: widget.food),
            DetailWidget(food: widget.food,),
          ],
        ),
      ),
    );
  }
}