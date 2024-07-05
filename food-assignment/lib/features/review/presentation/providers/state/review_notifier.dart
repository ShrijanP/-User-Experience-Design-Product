import 'dart:convert';

// import 'package:ecommerce_assignment/features/authentication/domain/repositories/auth_repository.dart';
// import 'package:ecommerce_assignment/features/authentication/presentation/providers/state/auth_state.dart';
// import 'package:ecommerce_assignment/features/review/presentation/providers/state/reivew_state.dart';
// import 'package:ecommerce_assignment/services/user_cache_service/domain/repositories/user_cache_repository.dart';
// import 'package:ecommerce_assignment/shared/constants/endpoint.dart';
// import 'package:ecommerce_assignment/shared/domain/models/review/review_response.dart';
// import 'package:ecommerce_assignment/shared/domain/models/user/user_model.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/review/presentation/providers/state/reivew_state.dart';
import 'package:hive/hive.dart';

// import '../../../../../shared/data/local/hive_config.dart';
import '../../../../services/user_cache_service/domain/repositories/user_cache_repository.dart';
import '../../../../shared/domain/models/review/review_response.dart';
import '../../../domain/repositories/review_repository.dart';

class ReviewNotifier extends StateNotifier<ReviewState> {
  final ReviewRepository authRepository;
  final UserRepository userRepository;

  ReviewNotifier({
    required this.authRepository,
    required this.userRepository,
  }) : super(const ReviewState.initial());

  Future<void> addReview(Map<String, dynamic> data) async {
    state = const ReviewState.loading();
    final response = await authRepository.addReview(
      data: data,
    );

    state = await response.fold(
      (failure) => ReviewState.failure(ReviewResponse()),
      (user) async {
        return ReviewState.success(ReviewResponse());
      },
    );
  }

  // Future<void> getReview(String data) async {
  //   Box box = HiveUtils.box;
  //   state = const ReviewState.loading();
  //   final response = await authRepository.getReview(
  //     data: data,
  //   );
  //
  //   state = await response.fold(
  //     (failure) async {
  //       dynamic response = await box.get(CustomerEndpoints.addReview);
  //       return ReviewState.failure(response);
  //     },
  //     (user) async {
  //       box.put(CustomerEndpoints.addReview, jsonEncode(user));
  //       return ReviewState.success(user);
  //     },
  //   );
  // }
}
