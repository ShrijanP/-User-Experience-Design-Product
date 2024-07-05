
import '../../../shared/domain/models/either.dart';
import '../../../shared/domain/models/order/my_order_response.dart';
import '../../../shared/exceptions/http_exception.dart';
import '../../domain/repositories/my_order_repository.dart';
import '../datasource/order_remote_data_source.dart';

class OrderRepositoryImpl extends OrderRepository {
  final OrderDataSource dataSource;

  OrderRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, MyOrderResponse>> fetchOrder() {
    return dataSource.fetchOrder();
  }
}
