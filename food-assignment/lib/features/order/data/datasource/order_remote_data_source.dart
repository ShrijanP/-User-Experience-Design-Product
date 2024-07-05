
// import 'package:ecommerce_assignment/shared/data/remote/remote.dart';
// import 'package:ecommerce_assignment/shared/domain/models/either.dart';
// import 'package:ecommerce_assignment/shared/domain/models/order/my_order_response.dart';
// import 'package:ecommerce_assignment/shared/domain/models/wishlist/my_wishlist_response.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';

import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

import '../../../shared/domain/models/order/my_order_response.dart';

abstract class OrderDataSource {

  Future<Either<AppException, MyOrderResponse>> fetchOrder();
}

class OrderRemoteDataSource implements OrderDataSource {
  final NetworkService networkService;

  OrderRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, MyOrderResponse>> fetchOrder() async {
    try {
      final eitherType = await networkService.get(
        "/carts/my-order",
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final data = MyOrderResponse.fromJson(response.data);
          print(data.data);
          return Right(data);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nWishlistRemoteDataSource.addWishlist',
        ),
      );
    }
  }
}
