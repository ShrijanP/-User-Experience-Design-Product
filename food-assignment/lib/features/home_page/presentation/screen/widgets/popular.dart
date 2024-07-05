// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:food_assignment/features/home_page/presentation/providers/state/dashboard_state.dart';
// import '../../../../../utils/config.dart';
// import '../../../../shared/constants/constants.dart';
// import '../../../../shared/constants/size_config.dart';
// import '../../providers/dashboard_state_provider.dart';
// import '../components/colors.dart';
//
// class PopularFoods extends ConsumerStatefulWidget {
//   const PopularFoods({Key? key}) : super(key: key);
//
//   @override
//   ConsumerState createState() => _PopularFoodsState();
// }
//
// class _PopularFoodsState extends ConsumerState<PopularFoods> {
//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(dashboardNotifierProvider);
//     ref.listen(
//       dashboardNotifierProvider.select((value) => value),
//       ((DashboardState? previous, DashboardState next) {
//         //show Snackbar on failure
//         if (next.state == DashboardConcreteState.fetchedAllProducts) {
//           if (next.message.isNotEmpty) {
//             ScaffoldMessenger.of(context)
//                 .showSnackBar(SnackBar(content: Text(next.message.toString())));
//           }
//         }
//       }),
//     );
//     return state.state == DashboardConcreteState.loading
//         ? const Center(child: CircularProgressIndicator())
//         : state.hasData
//             ? _buildBody(state)
//             : _buildBody(state);
//   }
// }
//
// Widget _buildBody(DashboardState state) {
//   return SizedBox(
//     height: SizeConfig.screenHeight! / 2.28,
//
//     /// 300.0
//     child: ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: state.productList.length >= 10 ? 10 : state.productList.length,
//       itemBuilder: (context, index) {
//         var food = state.productList[index];
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => FoodDetailView(food: food)));
//           },
//           child: Stack(
//             children: [
//               Container(
//                 margin: EdgeInsets.fromLTRB(
//                     SizeConfig.screenWidth! / 34.25,
//                     SizeConfig.screenHeight! / 113.84,
//                     SizeConfig.screenWidth! / 34.25,
//                     SizeConfig.screenHeight! / 22.77),
//                 height: SizeConfig.screenHeight! / 3.105,
//                 width: SizeConfig.screenWidth! / 2.74,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(30.0),
//                     boxShadow: [
//                       BoxShadow(
//                         offset: const Offset(0, 3),
//                         blurRadius: 6,
//                         color: Colors.black.withOpacity(0.3),
//                       )
//                     ]),
//                 child: Stack(
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         AspectRatio(
//                           aspectRatio: 1.02,
//                           child: Container(
//                             padding: const EdgeInsets.all(20),
//                             decoration: BoxDecoration(
//                               color: kSecondaryColor.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Image.network(food.images.isNotEmpty
//                                 ? "${AppConfigs.imageUrl}${food.images[0]}"
//                                 : "https://i.pinimg.com/564x/dd/f0/9d/ddf09d27fef66c6ca33e32446d9be544.jpg"),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 food.name,
//                                 style: TextStyle(
//                                     color: Colors.black54,
//                                     fontSize: SizeConfig.screenHeight! / 50.15,
//
//                                     /// 20
//                                     fontWeight: FontWeight.w700),
//                               ),
//                               // Text(
//                               //   "${food.foodCategory}",
//                               //   style: TextStyle(
//                               //       color: Colors.black38,
//                               //       fontSize:
//                               //       SizeConfig.screenHeight! / 60.69,
//                               //
//                               //       /// 16
//                               //       fontWeight: FontWeight.w400),
//                               // ),
//                               Padding(
//                                 padding: EdgeInsets.only(
//                                     top: SizeConfig.screenHeight! / 136.6),
//
//                                 /// 5.0
//                                 child: Text(
//                                   "\$${food.price}",
//                                   style: TextStyle(
//                                       color: buttonColor,
//                                       fontSize:
//                                           SizeConfig.screenHeight! / 60.95,
//
//                                       /// 18
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Container(
//                         height: SizeConfig.screenHeight! / 13.66,
//
//                         /// 50.0
//                         width: SizeConfig.screenWidth! / 8.22,
//
//                         /// 50.0
//                         decoration: BoxDecoration(
//                             color: buttonColor,
//                             borderRadius: const BorderRadius.only(
//                               bottomRight: Radius.circular(30.0),
//                               topLeft: Radius.circular(30.0),
//                             )),
//                         child: const Icon(
//                           Icons.shopping_cart_rounded,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }
