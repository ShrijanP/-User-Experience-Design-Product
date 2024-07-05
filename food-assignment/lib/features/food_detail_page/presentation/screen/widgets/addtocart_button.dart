// import 'package:flutter/material.dart';
// // import 'package:food_assignment/features/home_page/components/colors.dart';
// // import 'package:food_assignment/features/home_page/components/size_config.dart';
// import '../../../../cart_page/presentation/providers/state/cart_state.dart';
// import '../../../../home_page/presentation/screen/components/colors.dart';
// import '../../../../shared/constants/size_config.dart';
//
// class AddToCartButton extends StatelessWidget {
//   const AddToCartButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return Padding(
//       padding: EdgeInsets.fromLTRB(
//         SizeConfig.screenWidth! / 20.55,
//         SizeConfig.screenHeight! / 34.15,
//         SizeConfig.screenWidth! / 20.55,
//         0,
//       ),
//       child: Container(
//         decoration: BoxDecoration(
//           color: buttonColor,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: ElevatedButton(
//           style: ButtonStyle(
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//             ),
//             minimumSize: MaterialStateProperty.all(Size(
//                 SizeConfig.screenWidth!, SizeConfig.screenHeight! / 15.66)),
//             backgroundColor: MaterialStateProperty.all(Colors.transparent),
//             shadowColor: MaterialStateProperty.all(Colors.transparent),
//           ),
//           onPressed: state is Loading
//               ? null
//               : () {
//                   Map<String, dynamic> requestData = {
//                     "item": widget.food.id.toString(),
//                     // "variant": product.variant[0]["sku"].toString(),
//                     "quantity": quantity,
//                   };
//
//                   print(requestData);
//
//                   ref
//                       .read(addToCartStateNotifierProvider.notifier)
//                       .addToCart(requestData);
//                 },
//           child: Wrap(
//             children: [
//               Padding(
//                 padding:
//                     EdgeInsets.only(right: SizeConfig.screenWidth! / 51.38),
//                 child: const Icon(
//                   Icons.shopping_cart_rounded,
//                   color: Colors.white,
//                 ),
//               ),
//               Text(
//                 "Add to Cart",
//                 style: TextStyle(
//                   fontSize: SizeConfig.screenHeight! / 50.15,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
