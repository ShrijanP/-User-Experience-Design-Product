// import 'package:ecommerce_assignment/features/wishlist/presentation/providers/state/wishlist_notifier.dart';
// import 'package:ecommerce_assignment/features/wishlist/presentation/providers/state/wishlist_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/favorite_page/presentation/providers/state/wishlist_notifier.dart';
import 'package:food_assignment/features/favorite_page/presentation/providers/state/wishlist_state.dart';

import '../../domain/providers/wishlist_provider.dart';
import '../../domain/repositories/wishlist_repository.dart';

final addToWishlistStateNotifierProvider =
StateNotifierProvider<WishlistNotifier, WishlistState>(
      (ref) {
    final WishlistRepository wishlistRepository = ref.watch(wishlistRepositoryProvider);
    return WishlistNotifier(
      wishlistRepository: wishlistRepository,
    );
  },
);


final myWishlistStateNotifierProvider =
StateNotifierProvider<WishlistNotifier, WishlistState>(
      (ref) {
    final WishlistRepository wishlistRepository = ref.watch(wishlistRepositoryProvider);
    return WishlistNotifier(
      wishlistRepository: wishlistRepository,
    )..fetchWishlist();
  },
);