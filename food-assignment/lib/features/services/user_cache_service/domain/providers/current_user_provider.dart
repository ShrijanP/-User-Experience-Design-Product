import 'package:food_assignment/features/services/user_cache_service/domain/providers/user_cache_provider.dart';
import 'package:food_assignment/features/shared/domain/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/domain/models/login/login_response.dart';

final currentUserProvider = FutureProvider<LoginResponse?>((ref) async {
  final repository = ref.watch(userLocalRepositoryProvider);
  final eitherType = (await repository.fetchUser());

  return eitherType.fold((l) => null, (r) => r);
});
