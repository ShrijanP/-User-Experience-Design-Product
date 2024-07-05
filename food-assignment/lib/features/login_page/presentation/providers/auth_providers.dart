// import 'package:ecommerce_assignment/features/authentication/domain/providers/login_provider.dart';
// import 'package:ecommerce_assignment/features/authentication/domain/repositories/auth_repository.dart';
// import 'package:ecommerce_assignment/features/authentication/presentation/providers/state/auth_notifier.dart';
// import 'package:ecommerce_assignment/features/authentication/presentation/providers/state/auth_state.dart';
// import 'package:ecommerce_assignment/services/user_cache_service/domain/providers/user_cache_provider.dart';
// import 'package:ecommerce_assignment/services/user_cache_service/domain/repositories/user_cache_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/login_page/presentation/providers/state/auth_notifier.dart';
import 'package:food_assignment/features/login_page/presentation/providers/state/auth_state.dart';

import '../../../services/user_cache_service/domain/providers/user_cache_provider.dart';
import '../../../services/user_cache_service/domain/repositories/user_cache_repository.dart';
import '../../domain/providers/login_provider.dart';
import '../../domain/repositories/auth_repository.dart';

final authStateNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    final AuthenticationRepository authenticationRepository = ref.watch(authRepositoryProvider);
    final UserRepository userRepository = ref.watch(userLocalRepositoryProvider);
    return AuthNotifier(
      authRepository: authenticationRepository,
      userRepository: userRepository,
    );
  },
);

final registrationStateNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
      (ref) {
    final AuthenticationRepository authenticationRepository = ref.watch(authRepositoryProvider);
    final UserRepository userRepository = ref.watch(userLocalRepositoryProvider);
    return AuthNotifier(
      authRepository: authenticationRepository,
      userRepository: userRepository,
    );
  },
);

