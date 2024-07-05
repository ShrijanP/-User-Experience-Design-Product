// import 'package:ecommerce_assignment/features/authentication/data/repositories/authentication_repository_impl.dart';
// import 'package:ecommerce_assignment/features/authentication/domain/repositories/auth_repository.dart';
// import 'package:ecommerce_assignment/shared/data/remote/remote.dart';
// import 'package:ecommerce_assignment/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/shared/domain/providers/dio_network_service_provider.dart';

import '../../data/datasource/review_remote_datasource.dart';
import '../../data/repositories/review_repository.dart';
import '../repositories/review_repository.dart';

final reviewDataSourceProvider =
Provider.family<ReviewDataSource, NetworkService>(
      (_, networkService) => ReviewRemoteDataSource(networkService),
);

final reviewRepositoryProvider = Provider<ReviewRepository>(
      (ref) {
    final NetworkService networkService = ref.watch(networkServiceProvider);
    final ReviewDataSource dataSource =
    ref.watch(reviewDataSourceProvider(networkService));
    return ReviewRepositoryImpl(dataSource);
  },
);
