import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/configuration/food.dart';
import 'package:food_assignment/configuration/food_list.dart';
import 'package:food_assignment/features/cart_page/presentation/providers/state/cart_state.dart';
import 'package:food_assignment/features/cart_page/presentation/screen/widgets/food_list_widget/delete_icon_button.dart';
import 'package:food_assignment/features/cart_page/presentation/screen/widgets/food_list_widget/food_text.dart';
import 'package:food_assignment/features/cart_page/presentation/screen/widgets/food_list_widget/food_image.dart';
import 'package:food_assignment/features/shared/widgets/overlay_notification.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';
import 'package:lottie/lottie.dart';

import '../../../../shared/constants/size_config.dart';
import '../../../../shared/domain/models/cart/my_cart_response.dart';
import '../../providers/cart_state_providers.dart';

class FoodListWidget extends ConsumerStatefulWidget {
  const FoodListWidget({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _FoodListState();
}

class _FoodListState extends ConsumerState<FoodListWidget> {
  String totalItem = "0";

  @override
  void didChangeDependencies() {
    ref.watch(myCartStateNotifierProvider);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myCartStateNotifierProvider);
    final remoteState = ref.watch(removeCartStateNotifierProvider);
    ref.listen(
      removeCartStateNotifierProvider.select((value) => value),
      ((previous, next) {
        //show Snackbar on failure
        if (next is Failure) {
          showTopOverlayNotificationError(
              title: next.exception.message.toString());
        } else if (next is Success) {
          ref.read(myCartStateNotifierProvider.notifier).fetchMyCart();
          showTopOverlayNotification(title: "Cart Item Removed Successfully");
        }
      }),
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth! / 20),
      child: state.when(
          initial: () => const Center(
                child: Text("No Cart Found"),
              ),
          loading: () => const Center(child: CircularProgressIndicator()),
          failure: (failure, data) => data.data == null ||
                  data.data!.cartItems == null ||
                  data.data!.cartItems!.isEmpty
              ? _buildNoCartFound(context)
              : _buildBody(context, ref, data),
          success: (data) => data.data == null ||
                  data.data!.cartItems == null ||
                  data.data!.cartItems!.isEmpty
              ? _buildNoCartFound(context)
              : _buildBody(context, ref, data)),
    );
  }

  Widget _buildBody(
      BuildContext context, WidgetRef ref, MyCartResponse responseData) {
    var cartData = responseData.data?.cartItems;

    return RefreshIndicator(
      onRefresh: () {
        return ref.watch(myCartStateNotifierProvider.notifier).fetchMyCart();
      },
      child: ListView.builder(
          itemCount: cartData?.length,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            var food = cartData?[index];
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.screenHeight! / 68.3),
              child: Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) async {
                  setState(() {
                    var cartQuantity = int.parse(food.quantity.toString());

                    Map<String, dynamic> requestData = {
                      "cartitem": food.id.toString(),
                      "quantity": -cartQuantity,
                    };

                    print("CART ITEM::${requestData}");

                    ref
                        .read(removeCartStateNotifierProvider.notifier)
                        .removeCart(requestData);

                    ref.refresh(myCartStateNotifierProvider.notifier);
                    ref
                        .read(myCartStateNotifierProvider.notifier)
                        .fetchMyCart();
                  });
                },
                background: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth! / 20.55),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE6E6),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Row(
                    children: [Spacer(),
                      Icon(Icons.delete_outline)],
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(4, 6),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.1),
                        )
                      ]),
                  child: Row(
                    children: [
                      FoodImage(
                          foodImage: food!.item!.images!.first.toString()),
                      SizedBox(width: SizeConfig.screenWidth! / 20.55),
                      FoodText(
                        foodName: food.item!.name.toString(),
                        foodPrice: food.price.toString(),
                        quantity: food.quantity.toString(),
                      ),
                      const Spacer(),
                      // DeleteIconButton(foodName: food.item!.name.toString()),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildNoCartFound(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return ref.read(myCartStateNotifierProvider.notifier).fetchMyCart();
      },
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight! / 7.10),
            child: Column(
              children: [
                Center(
                    child: Icon(
                  Icons.shopping_cart,
                  color: Colors.black12,
                  size: SizeConfig.screenHeight! / 11.39,
                )),
                SizedBox(
                  height: SizeConfig.screenHeight! / 34.15,
                ),
                Center(
                    child: Text(
                  "Your Cart is Empty",
                  style: TextStyle(
                      color: Colors.black12,
                      fontSize: SizeConfig.screenHeight! / 34.15),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
