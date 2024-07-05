import 'package:flutter/material.dart';
import 'package:food_assignment/configuration/food.dart';
import 'package:food_assignment/features/shared/domain/models/product/product_model.dart';
// import 'package:food_assignment/features/home_page//components/size_config.dart';
import '../../../../shared/constants/size_config.dart';

class FoodName extends StatefulWidget {
  final Product food;
  const FoodName({super.key, required this.food});

  @override
  _FoodNameState createState() => _FoodNameState();
}

class _FoodNameState extends State<FoodName> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(children: [
      // Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children:[
      //       Text(widget.food.name, style: TextStyle(color: Colors.black, fontSize: SizeConfig.screenHeight!/22.77, fontFamily: "Roboto")),  /// 30
      //       // const Text("Category", style: TextStyle(color: Colors.black45, fontSize: 18)),
      //     ]
      // ),
      Expanded(
        child: Text(widget.food.name,
            style: TextStyle(
                color: Colors.black,
                fontSize: SizeConfig.screenHeight! / 50.77,
                fontFamily: "Roboto")),
      ),
      const Spacer(),
      Text(
        "Rs. ${widget.food.price}",
        style: TextStyle(
            color: Colors.black87, fontSize: SizeConfig.screenHeight! / 50.77),
      ),
    ]);
  }
}
