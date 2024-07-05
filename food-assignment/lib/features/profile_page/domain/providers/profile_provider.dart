// import 'package:ecommerce_assignment/features/shared/data/remote/remote.dart';
// import 'package:ecommerce_assignment/features/shared/domain/providers/dio_network_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/shared/domain/providers/dio_network_service_provider.dart';

import '../../../shared/data/remote/remote.dart';
import '../../data/datasource/profile_remote_data_source.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../repositories/profile_repository.dart';

final profileDataSourceProvider =
    Provider.family<ProfileDataSource, NetworkService>(
  (_, networkService) => ProfileRemoteDataSource(networkService),
);

final profileRepositoryProvider = Provider<ProfileRepository>(
  (ref) {
    final NetworkService networkService = ref.watch(networkServiceProvider);
    final ProfileDataSource dataSource = ref.watch(profileDataSourceProvider(networkService));
    return ProfileRepositoryImpl(dataSource);
  },
);
