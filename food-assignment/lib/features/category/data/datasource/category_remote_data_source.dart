// import 'package:ecommerce_assignment/shared/data/remote/remote.dart';
// import 'package:ecommerce_assignment/shared/domain/models/category/category_response.dart';
// import 'package:ecommerce_assignment/shared/domain/models/either.dart';
// import 'package:ecommerce_assignment/shared/domain/models/order/my_order_response.dart';
// import 'package:ecommerce_assignment/shared/domain/models/wishlist/my_wishlist_response.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';

// import '../../../../shared/constants/endpoint.dart';

import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/shared/domain/models/category/category_response.dart';

import '../../../shared/constants/endpoint.dart';
import '../../../shared/domain/models/either.dart';
import '../../../shared/exceptions/http_exception.dart';

abstract class CategoryDataSource {
  Future<Either<AppException, CategoryResponse>> fetchCategory();
}

class CategoryRemoteDataSource implements CategoryDataSource {
  final NetworkService networkService;

  CategoryRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, CategoryResponse>> fetchCategory() async {
    try {
      final eitherType = await networkService.get(
        CustomerEndpoints.category,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final data = CategoryResponse.fromJson(response.data);
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
