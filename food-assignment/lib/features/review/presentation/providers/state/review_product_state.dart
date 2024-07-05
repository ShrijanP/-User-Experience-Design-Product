
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/domain/models/review/review_response.dart';

part 'review_product_state.freezed.dart';

@freezed
abstract class ReviewProductState with _$ReviewProductState {
  const factory ReviewProductState.initial() = Initial;
  const factory ReviewProductState.loading() = Loading;
  const factory ReviewProductState.failure(ReviewResponse data) = Failure;
  const factory ReviewProductState.success(ReviewResponse data) = Success;
}
