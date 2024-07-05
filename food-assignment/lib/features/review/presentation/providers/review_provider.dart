import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/review/presentation/providers/state/reivew_state.dart';
import 'package:food_assignment/features/review/presentation/providers/state/review_notifier.dart';

import '../../../services/user_cache_service/domain/providers/user_cache_provider.dart';
import '../../../services/user_cache_service/domain/repositories/user_cache_repository.dart';
import '../../domain/providers/review_providers.dart';
import '../../domain/repositories/review_repository.dart';

final reviewStateNotifierProvider =
    StateNotifierProvider<ReviewNotifier, ReviewState>(
  (ref) {
    final ReviewRepository reviewRepository =
        ref.watch(reviewRepositoryProvider);
    final UserRepository userRepository =
        ref.watch(userLocalRepositoryProvider);
    return ReviewNotifier(
      userRepository: userRepository,
      authRepository: reviewRepository,
    );
  },
);

