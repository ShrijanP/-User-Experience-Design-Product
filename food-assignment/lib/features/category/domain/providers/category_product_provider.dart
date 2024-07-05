import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/shared/domain/providers/dio_network_service_provider.dart';
// import '../../../../shared/data/remote/network_service.dart';
// import '../../../../shared/domain/providers/dio_network_service_provider.dart';
import '../../data/datasource/category_product_remote_data_source.dart';
import '../../data/repositories/category_prodcut_repository_impl.dart';
import '../repositories/category_product_repository.dart';

final categoryProductDatasourceProvider =
Provider.family<CategoryProductDatasource, NetworkService>(
      (_, networkService) => CategoryProductRemoteDatasource(networkService),
);

final categoryProductRepositoryProvider = Provider<CategoryProductRepository>((ref) {
  final networkService = ref.watch(networkServiceProvider);
  final datasource = ref.watch(categoryProductDatasourceProvider(networkService));
  final repository = CategoryProductRepositoryImpl(datasource);

  return repository;
});