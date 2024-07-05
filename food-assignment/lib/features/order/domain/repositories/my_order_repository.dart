
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

import '../../../shared/domain/models/either.dart';
import '../../../shared/domain/models/order/my_order_response.dart';

abstract class OrderRepository {
  Future<Either<AppException, MyOrderResponse>> fetchOrder();
}
