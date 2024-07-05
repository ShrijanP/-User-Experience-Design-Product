import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/cart_page/presentation/screen/widgets/bottom_bar_widget/3d_secure.dart';
import 'package:food_assignment/features/cart_page/presentation/screen/widgets/bottom_bar_widget/bottombar_text.dart';
import 'package:food_assignment/features/cart_page/presentation/screen/widgets/bottom_bar_widget/checkout_button.dart';
import 'package:food_assignment/features/food_detail_page/presentation/screen/components/separator.dart';
import 'package:food_assignment/features/shared/constants/size_config.dart';

import '../../../../shared/domain/models/cart/my_cart_response.dart';
import '../../providers/cart_state_providers.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myCartStateNotifierProvider);
    return state.when(
        initial: () => const Center(
              child: Text("No Cart Found"),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        failure: (failure, data) => data.data == null ||
                data.data!.cartItems == null ||
                data.data!.cartItems!.isEmpty
            ? _buildBody(context, ref, data)
            : _buildBody(context, ref, data),
        success: (data) => data.data == null ||
                data.data!.cartItems == null ||
                data.data!.cartItems!.isEmpty
            ? _buildBody(context, ref, data)
            : _buildBody(context, ref, data));
  }

  Widget _buildBody(
      BuildContext context, WidgetRef ref, MyCartResponse responseData) {
    var cartData = responseData.data?.cart;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.screenHeight! / 15.0,
        horizontal: SizeConfig.screenHeight! / 30.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(bottom: SizeConfig.screenHeight! / 85.37),
              child: const MySeparator(
                color: Colors.grey,
              ),
            ),
            // const ThreeDSecure(),
            SizedBox(
              height: SizeConfig.screenHeight! / 45.54,
            ),
            BottomBarText(
                title_text: "Subtotal",
                price_text: "Rs.${cartData?.total.toString()}",
                font_size: SizeConfig.screenHeight! / 55.54,
                fontWeight: FontWeight.w400,
                text_color: Colors.black54),
            SizedBox(
              height: SizeConfig.screenHeight! / 45.54,
            ),
            BottomBarText(
              title_text: "Discount",
              price_text: "Rs.${cartData?.discount.toString()}",
              font_size: SizeConfig.screenHeight! / 55.54,
              fontWeight: FontWeight.w400,
              text_color: Colors.black54,
            ),
            SizedBox(
              height: SizeConfig.screenHeight! / 45.54,
            ),
            BottomBarText(
              title_text: "Total",
              price_text: "Rs.${cartData?.grandTotal.toString()}",
              font_size: SizeConfig.screenHeight! / 45.95,
              fontWeight: FontWeight.bold,
              text_color: Colors.black,
            ),
            SizedBox(height: SizeConfig.screenHeight! / 34.15),
            responseData.data!.cartItems!.isEmpty ||
                    cartData == null ||
                    cartData.id == null
                ? Container()
                : CheckoutButton(
                    cartId: cartData.id.toString(),
                    amount: cartData.grandTotal.toString(),
                  ),
          ],
        ),
      ),
    );
  }
}
