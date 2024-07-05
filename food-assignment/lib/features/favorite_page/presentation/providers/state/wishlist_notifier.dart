import 'dart:convert';

// import 'package:ecommerce_assignment/features/wishlist/presentation/providers/state/wishlist_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/favorite_page/presentation/providers/state/wishlist_state.dart';
import 'package:hive/hive.dart';
// import '../../../../../shared/data/local/hive_config.dart';
// import '../../../../../shared/domain/models/wishlist/my_wishlist_response.dart';
import '../../../../shared/data/local/hive_config.dart';
import '../../../../shared/domain/models/wishlist/my_wishlist_response.dart';
import '../../../domain/repositories/wishlist_repository.dart';

class WishlistNotifier extends StateNotifier<WishlistState> {
  final WishlistRepository wishlistRepository;

  WishlistNotifier({
    required this.wishlistRepository,
  }) : super(const WishlistState.initial());

  Future<void> addToWishlist(String id) async {
    state = const WishlistState.loading();
    final response = await wishlistRepository.addToWishlist(
      requestData: id,
    );

    state = await response.fold(
      (failure) => WishlistState.failure(failure, WishlistResponse()),
      (message) async {
        // fetchMyCart();
        return WishlistState.success(WishlistResponse());
      },
    );
  }

  Future<void> fetchWishlist() async {
    Box box = HiveUtils.box;
    state = const WishlistState.loading();
    final response = await wishlistRepository.fetchWishlist();

    state = await response.fold(
      (failure) async {
        dynamic response = await box.get("/wishlist");
        return WishlistState.failure(
            failure, response != null? WishlistResponse.fromJson(jsonDecode(response)): WishlistResponse());
      },
      (data) async {
        box.put("/wishlist", jsonEncode(data));
        return WishlistState.success(data);
      },
    );
  }
}
