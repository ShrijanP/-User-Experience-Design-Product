
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/order/presentation/providers/state/order_notifier.dart';
import 'package:food_assignment/features/order/presentation/providers/state/order_state.dart';

import '../../domain/providers/my_order_provider.dart';
import '../../domain/repositories/my_order_repository.dart';

final myOrderStateNotifierProvider =
StateNotifierProvider<OrderNotifier, OrderState>(
      (ref) {
    final OrderRepository orderRepository = ref.watch(orderRepositoryProvider);
    return OrderNotifier(
      orderRepository: orderRepository,
    )..fetchOrder();
  },
);