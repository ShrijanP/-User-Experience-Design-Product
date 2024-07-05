// import 'package:ecommerce_assignment/features/cart/presentation/providers/state/cart_notifier.dart';
// import 'package:ecommerce_assignment/features/cart/presentation/providers/state/cart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/cart_page/presentation/providers/state/cart_notifier.dart';
import 'package:food_assignment/features/cart_page/presentation/providers/state/cart_state.dart';

import '../../domain/providers/add_to_cart_provider.dart';
import '../../domain/repositories/cart_repository.dart';

final addToCartStateNotifierProvider =
    StateNotifierProvider<CartNotifier, CartState>(
  (ref) {
    final CartRepository cartRepository = ref.watch(cartRepositoryProvider);
    return CartNotifier(
      cartRepository: cartRepository,
    );
  },
);

final myCartStateNotifierProvider =
    StateNotifierProvider<CartNotifier, CartState>(
  (ref) {
    final CartRepository cartRepository = ref.watch(cartRepositoryProvider);
    return CartNotifier(
      cartRepository: cartRepository,
    )..fetchMyCart();
  },
);

final removeCartStateNotifierProvider =
    StateNotifierProvider<CartNotifier, CartState>(
  (ref) {
    final CartRepository cartRepository = ref.watch(cartRepositoryProvider);
    return CartNotifier(
      cartRepository: cartRepository,
    );
  },
);

final checkOutStateNotifierProvider =
StateNotifierProvider<CartNotifier, CartState>(
      (ref) {
    final CartRepository cartRepository = ref.watch(cartRepositoryProvider);
    return CartNotifier(
      cartRepository: cartRepository,
    );
  },
);
