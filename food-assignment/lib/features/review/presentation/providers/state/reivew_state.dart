import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/models/review/review_response.dart';

part 'reivew_state.freezed.dart';

@freezed
abstract class ReviewState with _$ReviewState {
  const factory ReviewState.initial() = Initial;
  const factory ReviewState.loading() = Loading;
  const factory ReviewState.failure(ReviewResponse data) = Failure;
  const factory ReviewState.success(ReviewResponse data) = Success;
}
