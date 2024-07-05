import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../shared/domain/models/order/my_order_response.dart';
import '../../../../shared/exceptions/http_exception.dart';

part 'order_state.freezed.dart';

@freezed
abstract class OrderState with _$OrderState {
  const factory OrderState.initial() = Initial;
  const factory OrderState.loading() = Loading;
  const factory OrderState.failure(AppException exception, MyOrderResponse data) = Failure;
  const factory OrderState.success(MyOrderResponse data) = Success;
}
