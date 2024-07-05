import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/shared/data/remote/remote.dart';

import '../../../shared/domain/providers/dio_network_service_provider.dart';
import '../../data/datasource/order_remote_data_source.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../repositories/my_order_repository.dart';

final orderDataSourceProvider =
Provider.family<OrderDataSource, NetworkService>(
      (_, networkService) => OrderRemoteDataSource(networkService),
);

final orderRepositoryProvider = Provider<OrderRepository>(
      (ref) {
    final NetworkService networkService = ref.watch(networkServiceProvider);
    final OrderDataSource dataSource =
    ref.watch(orderDataSourceProvider(networkService));
    return OrderRepositoryImpl(dataSource);
  },
);
