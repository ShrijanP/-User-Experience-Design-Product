import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/configuration/food.dart';
import 'package:food_assignment/configuration/food_list.dart';
import 'package:food_assignment/features/shared/widgets/overlay_notification.dart';

import '../../../../favorite_page/presentation/providers/state/wishlist_state.dart';
import '../../../../favorite_page/presentation/providers/wishlist_state_providers.dart';
import '../../../../shared/utils/config.dart';
import '../../../../food_detail_page/presentation/screen/food_detail_view.dart';
import '../../../../review/presentation/providers/review_product_provider.dart';
import '../../../../shared/constants/size_config.dart';
import '../../providers/dashboard_state_provider.dart';
import '../../providers/state/dashboard_state.dart';

class RecommedFoods extends ConsumerStatefulWidget {
  const RecommedFoods({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _RecommedFoodsState();
}

class _RecommedFoodsState extends ConsumerState<RecommedFoods> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardNotifierProvider);
    ref.listen(
      dashboardNotifierProvider.select((value) => value),
      ((DashboardState? previous, DashboardState next) {
        //show Snackbar on failure
        if (next.state == DashboardConcreteState.fetchedAllProducts) {
          if (next.message.isNotEmpty) {
            // showTopOverlayNotification(title: next.message.toString());
          }
        }
      }),
    );

    final state2 = ref.watch(addToWishlistStateNotifierProvider);
    ref.listen(
      addToWishlistStateNotifierProvider.select((value) => value),
      ((previous, next) {
        if (next is Failure) {
          showTopOverlayNotificationError(
              title: next.exception.message.toString());
        } else if (next is Success) {
          showTopOverlayNotification(
              title: "Wishlist has been Successfully Added");
          ref.read(myWishlistStateNotifierProvider.notifier).fetchWishlist();
        }
      }),
    );

    return state.state == DashboardConcreteState.loading
        ? const Center(child: CircularProgressIndicator())
        : state.hasData
            ? _buildBody(state)
            : _buildBody(state);
  }

  Widget _buildBody(DashboardState state) {
    return state.productList.isEmpty
        ? const Center(child: Text("No Product Found"))
        : SizedBox(
            height: SizeConfig.screenHeight! / 2.58,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.productList.length >= 10
                  ? 10
                  : state.productList.length,
              itemBuilder: (context, index) {
                var food = state.productList[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref
                            .watch(getReviewStateNotifierProvider.notifier)
                            .getReview(food.id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FoodDetailView(food: food)));
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(
                          SizeConfig.screenWidth! / 34.25,
                          SizeConfig.screenHeight! / 170.75,
                          SizeConfig.screenWidth! / 41.1,
                          SizeConfig.screenHeight! / 170.75,
                        ),
                        height: SizeConfig.screenHeight! / 2.73,
                        width: SizeConfig.screenWidth! / 2.055,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: food.images.isNotEmpty
                                  ? Image.network(
                                      "${AppConfigs.imageUrl}${food.images[0]}",
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Image.network(
                                          "https://i.pinimg.com/564x/dd/f0/9d/ddf09d27fef66c6ca33e32446d9be544.jpg",
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.network(
                                      "https://i.pinimg.com/564x/dd/f0/9d/ddf09d27fef66c6ca33e32446d9be544.jpg",
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Positioned(
                                left: SizeConfig.screenWidth! / 34.25,
                                bottom: SizeConfig.screenHeight! / 45.54,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(food.name,
                                        style: TextStyle(
                                            fontSize: SizeConfig.screenHeight! /
                                                50.15,
                                            color: Colors.white)),
                                    Row(
                                      children: [
                                        const Icon(Icons.fastfood,
                                            color: Colors.white),
                                        Text(
                                            " ${food.calorie_count.toString()}",
                                            style: TextStyle(
                                                fontSize:
                                                    SizeConfig.screenHeight! /
                                                        60.79,
                                                color: Colors.white)),
                                      ],
                                    ),
                                    Text("Rs. ${food.price}",
                                        style: TextStyle(
                                            fontSize: SizeConfig.screenHeight! /
                                                60.95,
                                            color: Colors.white))
                                  ],
                                )),
                            Positioned(
                                top: SizeConfig.screenHeight! / 68.3,
                                right: SizeConfig.screenWidth! / 41.1,
                                child: GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(addToWishlistStateNotifierProvider
                                            .notifier)
                                        .addToWishlist(
                                            food.id.toString());
                                    ref
                                        .read(myWishlistStateNotifierProvider
                                            .notifier)
                                        .fetchWishlist();
                                  },
                                  child: const Icon(Icons.favorite,
                                      color: Colors.white),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
  }
}
