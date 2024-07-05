import 'dart:convert';

// import 'package:ecommerce_assignment/features/review/presentation/providers/state/review_product_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/review/presentation/providers/state/review_product_state.dart';
import 'package:hive/hive.dart';
import '../../../../services/user_cache_service/domain/repositories/user_cache_repository.dart';
import '../../../../shared/constants/endpoint.dart';
import '../../../../shared/data/local/hive_config.dart';
import '../../../../shared/domain/models/review/review_response.dart';
import '../../../domain/repositories/review_repository.dart';

class ReviewProductNotifier extends StateNotifier<ReviewProductState> {
  final ReviewRepository authRepository;
  final UserRepository userRepository;

  ReviewProductNotifier({
    required this.authRepository,
    required this.userRepository,
  }) : super(const ReviewProductState.initial());

  Future<void> getReview(String data) async {
    Box box = HiveUtils.box;
    state = const ReviewProductState.loading();
    final response = await authRepository.getReview(
      data: data,
    );

    state = await response.fold(
      (failure) async {
        dynamic res;
        dynamic response = await box.get(CustomerEndpoints.addReview);

        //decode
        dynamic responseDecode = jsonDecode(response);

        res = ReviewResponse.fromJson(responseDecode);

        return ReviewProductState.failure(res);

      },
      (user) async {
        box.put(CustomerEndpoints.addReview, jsonEncode(user));
        return ReviewProductState.success(user);
      },
    );
  }
}
