import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/favorite_page/presentation/providers/state/wishlist_state.dart';
import 'package:food_assignment/features/favorite_page/presentation/screen/widgets/favorite_cart_icon.dart';
import 'package:food_assignment/features/favorite_page/presentation/screen/widgets/favorite_icon.dart';
import 'package:food_assignment/features/favorite_page/presentation/screen/widgets/favorite_image.dart';

import '../../../shared/constants/size_config.dart';
import '../../../shared/domain/models/wishlist/my_wishlist_response.dart';
import '../../../shared/widgets/overlay_notification.dart';
import '../providers/wishlist_state_providers.dart';

class FavoritePageView extends ConsumerStatefulWidget {
  const FavoritePageView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _FavoritePageViewState();
}

class _FavoritePageViewState extends ConsumerState<FavoritePageView> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myWishlistStateNotifierProvider);

    ref.watch(addToWishlistStateNotifierProvider);

    ref.listen(
      addToWishlistStateNotifierProvider.select((value) => value),
      ((previous, next) {
        if (next is Failure) {
          showTopOverlayNotificationError(
              title: next.exception.message.toString());
        } else if (next is Success) {
          showTopOverlayNotification(
              title: "Wishlist has been Successfully Removed");
          ref.read(myWishlistStateNotifierProvider.notifier).fetchWishlist();
        }
      }),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Favorite",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: state.when(
          initial: () => const Center(
                child: Text("No wishlist Found"),
              ),
          loading: () => const Center(child: CircularProgressIndicator()),
          failure: (failure, data) => data.data == null || data.data!.isEmpty
              ? _buildNoCartFound(context)
              : _buildBody(context, ref, data),
          success: (data) => data.data == null || data.data!.isEmpty
              ? _buildNoCartFound(context)
              : _buildBody(context, ref, data)),
    );
  }

  Widget _buildBody(
      BuildContext context, WidgetRef ref, WishlistResponse responseData) {
    var foodList = responseData.data;
    print("FOOD DTA IS::${foodList}");
    return foodList == null || foodList.isEmpty
        ? _buildNoCartFound(context)
        : Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth! / 20.0,
                vertical: SizeConfig.screenHeight! / 136.6),
            child: GridView.builder(
                itemCount: foodList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  childAspectRatio: 3.2 / 4,
                ),
                itemBuilder: (context, index) {
                  var food = foodList[index];
                  return Stack(
                    children: [
                      Container(
                          height: SizeConfig.screenHeight! / 3.10,
                          width: SizeConfig.screenWidth! / 2.06,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 3),
                                  blurRadius: 6,
                                  color: Colors.black.withOpacity(0.1),
                                )
                              ]),
                          child: Stack(
                            children: [
                              food.product == null
                                  ? const Text("")
                                  : FavoriteDetail(
                                      food_image_name: food
                                          .product!.images!.first
                                          .toString(),
                                      food_name: food.product!.name.toString(),
                                      food_category: "",
                                      food_price:
                                          food.product!.price.toString()),
                              const FavoriteCartIcon(),
                              Positioned(
                                  top: SizeConfig.screenHeight! / 56.92,
                                  right: SizeConfig.screenWidth! / 34.25,
                                  child: GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(
                                              addToWishlistStateNotifierProvider
                                                  .notifier)
                                          .addToWishlist(
                                              food.product!.id.toString());

                                      ref.refresh(
                                          myWishlistStateNotifierProvider
                                              .notifier);

                                      ref
                                          .read(myWishlistStateNotifierProvider
                                              .notifier)
                                          .fetchWishlist();
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                    ),
                                  )),
                            ],
                          )),
                    ],
                  );
                }),
          );
  }

  Widget _buildNoCartFound(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return ref
            .read(myWishlistStateNotifierProvider.notifier)
            .fetchWishlist();
      },
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: SizeConfig.screenHeight! / 3.10),

            /// 200.0
            child: Column(
              children: [
                Center(
                    child: Icon(
                  Icons.favorite,
                  color: Colors.black12,
                  size: SizeConfig.screenHeight! / 11.39,
                )),

                /// 60.0
                SizedBox(
                  height: SizeConfig.screenHeight! / 34.15,
                ),

                /// 20.0
                Center(
                    child: Text(
                  "Your Favorite Foods",
                  style: TextStyle(
                      color: Colors.black12,
                      fontSize: SizeConfig.screenHeight! / 34.15),
                ))

                /// 20.0
              ],
            ),
          ),
        ],
      ),
    );
  }
}
