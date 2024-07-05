// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// import '../../../../../shared/domain/models/user/profile_info_model.dart';
import '../../../../shared/domain/models/user/profile_info_model.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = Initial;
  const factory ProfileState.loading() = Loading;
  const factory ProfileState.failure(AppException exception, ProfileInfoResponse data) = Failure;
  const factory ProfileState.success(ProfileInfoResponse data) = Success;
}

