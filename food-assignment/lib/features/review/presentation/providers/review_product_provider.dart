
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/review/presentation/providers/state/review_product_notifier.dart';
import 'package:food_assignment/features/review/presentation/providers/state/review_product_state.dart';

import '../../../services/user_cache_service/domain/providers/user_cache_provider.dart';
import '../../../services/user_cache_service/domain/repositories/user_cache_repository.dart';
import '../../domain/providers/review_providers.dart';
import '../../domain/repositories/review_repository.dart';

final getReviewStateNotifierProvider =
StateNotifierProvider<ReviewProductNotifier, ReviewProductState>(
      (ref) {
    final ReviewRepository reviewRepository =
    ref.watch(reviewRepositoryProvider);
    final UserRepository userRepository =
    ref.watch(userLocalRepositoryProvider);
    return ReviewProductNotifier(
      userRepository: userRepository,
      authRepository: reviewRepository,
    );
  },
);
