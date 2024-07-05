import 'dart:convert';

// import 'package:ecommerce_assignment/shared/domain/models/cart/add_to_cart_response.dart';
// import 'package:ecommerce_assignment/shared/domain/models/user/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/shared/domain/models/cart/my_cart_response.dart';
import 'package:hive/hive.dart';

// import '../../../../../shared/constants/endpoint.dart';
// import '../../../../../shared/data/local/hive_config.dart';
// import '../../../../../shared/domain/models/cart/my_cart_response.dart';
import '../../../../shared/constants/endpoint.dart';
import '../../../../shared/data/local/hive_config.dart';
import '../../../domain/repositories/cart_repository.dart';
import 'cart_state.dart';

class CartNotifier extends StateNotifier<CartState> {
  final CartRepository cartRepository;

  CartNotifier({
    required this.cartRepository,
  }) : super(const CartState.initial());

  Future<void> addToCart(Map<String, dynamic> requestData) async {
    state = const CartState.loading();
    final response = await cartRepository.addToCart(
      requestData: requestData,
    );

    state = await response.fold(
      (failure) => CartState.failure(failure, MyCartResponse()),
      (user) async {
        fetchMyCart();
        return CartState.success(MyCartResponse());
      },
    );
  }

  Future<void> fetchMyCart() async {
    Box box = HiveUtils.box;
    state = const CartState.loading();
    final response = await cartRepository.fetchMyCart();

    state = await response.fold(
      (failure)async{
        dynamic response = await box.get(CustomerEndpoints.myCart);
        return CartState.failure(failure, response == null ? MyCartResponse() : MyCartResponse.fromJson(jsonDecode(response)));
      },
      (data) async {
        box.put(CustomerEndpoints.myCart, jsonEncode(data));
        return CartState.success(data);
      },
    );
  }

  Future<void> removeCart(Map<String, dynamic> requestData) async {
    state = const CartState.loading();
    final response = await cartRepository.removeCart(
      requestData: requestData,
    );

    state = await response.fold(
          (failure) => CartState.failure(failure, MyCartResponse()),
          (user) async {
        return CartState.success(MyCartResponse());
      },
    );
  }

  Future<void> checkOUt(String requestData, String id) async {
    state = const CartState.loading();
    final response = await cartRepository.checkOut(
      requestData: requestData,
      id: id,
    );

    state = await response.fold(
          (failure) => CartState.failure(failure, MyCartResponse()),
          (user) async {
        return CartState.success(MyCartResponse());
      },
    );
  }
}
