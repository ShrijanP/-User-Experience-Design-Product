import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/order/presentation/providers/state/order_state.dart';
import 'package:hive/hive.dart';
import '../../../../shared/data/local/hive_config.dart';
import '../../../../shared/domain/models/order/my_order_response.dart';
import '../../../domain/repositories/my_order_repository.dart';

class OrderNotifier extends StateNotifier<OrderState> {
  final OrderRepository orderRepository;

  OrderNotifier({
    required this.orderRepository,
  }) : super(const OrderState.initial());

  Future<void> fetchOrder() async {
    Box box = HiveUtils.box;
    state = const OrderState.loading();
    final response = await orderRepository.fetchOrder();

    state = await response.fold(
      (failure) async {
        dynamic response = await box.get("/carts/my-order");
        return OrderState.failure(
            failure,
            response != null
                ? MyOrderResponse.fromJson(jsonDecode(response))
                : MyOrderResponse());
      },
      (data) async {
        box.put("/carts/my-order", jsonEncode(data));
        return OrderState.success(data);
      },
    );
  }
}
