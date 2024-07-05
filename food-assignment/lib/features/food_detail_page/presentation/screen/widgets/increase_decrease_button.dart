import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/configuration/food.dart';
import 'package:food_assignment/features/shared/domain/models/product/product_model.dart';
// import 'package:food_assignment/features/food_detail_page/components/separator.dart';
// import 'package:food_assignment/features/home_page/components/colors.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';
import '../../../../cart_page/presentation/providers/cart_state_providers.dart';
import '../../../../cart_page/presentation/providers/state/cart_state.dart';
import '../../../../shared/widgets/overlay_notification.dart';
import '../../../../home_page/presentation/screen/components/colors.dart';
import '../../../../shared/constants/size_config.dart';
import '../components/separator.dart';

class IncreaseDecrease extends ConsumerStatefulWidget {
  final Product food;
  const IncreaseDecrease({super.key, required this.food});

  @override
  ConsumerState createState() => _IncreaseDecreaseState();
}

class _IncreaseDecreaseState extends ConsumerState<IncreaseDecrease> {
  int _counter = 1;

  void _increaseCart() {
    setState(() {
      _counter++;
    });
  }

  void _decreaseCart() {
    setState(() {
      if (_counter > 1) {
        _counter--;
      } else {
        _counter = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final state = ref.watch(addToCartStateNotifierProvider);
    ref.listen(
      addToCartStateNotifierProvider.select((value) => value),
      ((previous, next) {
        if (next is Failure) {
          showTopOverlayNotificationError(
              title: next.exception.message.toString());
        } else if (next is Success) {
          showTopOverlayNotification(title: "Cart has been Successfully Added");
          ref.read(myCartStateNotifierProvider.notifier).fetchMyCart();
        }
      }),
    );
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.screenHeight! / 45.54),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.screenHeight! / 68.3,
                bottom: SizeConfig.screenHeight! / 34.15),
            child: const MySeparator(
              color: Colors.grey,
            ),
          ),
          Text(
            "Total",
            style: TextStyle(
                color: Colors.black54,
                fontSize: SizeConfig.screenHeight! / 55.69),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rs. ${int.parse(widget.food.price.toString()) * _counter}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.screenHeight! / 50.32),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _decreaseCart();
                    },
                    child: Container(
                      height: SizeConfig.screenHeight! / 20.94,
                      width: SizeConfig.screenWidth! / 12.39,
                      decoration: BoxDecoration(
                        border: Border.all(color: buttonColor, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        color: textColor.withOpacity(0.1),
                        //borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: Icon(Icons.remove, color: buttonColor),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth! / 10.85,
                    height: SizeConfig.screenHeight! / 13.94,
                    child: Center(
                      child: Text(
                        "$_counter",
                        style: TextStyle(
                            fontSize: SizeConfig.screenHeight! / 45.95,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _increaseCart();
                    },
                    child: Container(
                      height: SizeConfig.screenHeight! / 20.94,
                      width: SizeConfig.screenWidth! / 12.39,
                      decoration: BoxDecoration(
                        border: Border.all(color: buttonColor, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        color: textColor.withOpacity(0.4),
                      ),
                      child: Center(
                        child: Icon(Icons.add, color: buttonColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              SizeConfig.screenWidth! / 20.55,
              SizeConfig.screenHeight! / 34.15,
              SizeConfig.screenWidth! / 20.55,
              0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(
                      SizeConfig.screenWidth!,
                      SizeConfig.screenHeight! / 15.66)),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: state is Loading
                    ? null
                    : () {
                        Map<String, dynamic> requestData = {
                          "item": widget.food.id.toString(),
                          "quantity": _counter,
                        };

                        print(requestData);

                        ref
                            .read(addToCartStateNotifierProvider.notifier)
                            .addToCart(requestData);
                      },
                child: Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: SizeConfig.screenWidth! / 51.38),
                      child: const Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Add to Cart",
                      style: TextStyle(
                        fontSize: SizeConfig.screenHeight! / 50.15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
