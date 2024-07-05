// import 'package:ecommerce_assignment/shared/data/remote/remote.dart';
// import 'package:ecommerce_assignment/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/shared/domain/providers/dio_network_service_provider.dart';

import '../../data/datasource/category_remote_data_source.dart';
import '../../data/repositories/category_repository_impl.dart';
import '../repositories/category_repository.dart';

final categoryDataSourceProvider =
Provider.family<CategoryDataSource, NetworkService>(
      (_, networkService) => CategoryRemoteDataSource(networkService),
);

final categoryRepositoryProvider = Provider<CategoryRepository>(
      (ref) {
    final NetworkService networkService = ref.watch(networkServiceProvider);
    final CategoryDataSource dataSource =
    ref.watch(categoryDataSourceProvider(networkService));
    return CategoryRepositoryImpl(dataSource);
  },
);
