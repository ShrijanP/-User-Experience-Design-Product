import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasource/cart_remote_data_source.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../repositories/cart_repository.dart';

final cartDataSourceProvider =
    Provider.family<CartDataSource, NetworkService>(
  (_, networkService) => CartRemoteDataSource(networkService),
);

final cartRepositoryProvider = Provider<CartRepository>(
  (ref) {
    final NetworkService networkService = ref.watch(networkServiceProvider);
    final CartDataSource dataSource =
        ref.watch(cartDataSourceProvider(networkService));
    return CartRepositoryImpl(dataSource);
  },
);
