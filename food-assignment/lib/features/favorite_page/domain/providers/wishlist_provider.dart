
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/shared/domain/providers/dio_network_service_provider.dart';

import '../../data/datasource/wishlist_remote_data_source.dart';
import '../../data/repositories/wishlist_repository_impl.dart';
import '../repositories/wishlist_repository.dart';

final wishlistDataSourceProvider =
Provider.family<WishlistDataSource, NetworkService>(
      (_, networkService) => WishlistRemoteDataSource(networkService),
);

final wishlistRepositoryProvider = Provider<WishlistRepository>(
      (ref) {
    final NetworkService networkService = ref.watch(networkServiceProvider);
    final WishlistDataSource dataSource =
    ref.watch(wishlistDataSourceProvider(networkService));
    return WishlistRepositoryImpl(dataSource);
  },
);
