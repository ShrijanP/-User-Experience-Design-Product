// import 'package:ecommerce_assignment/shared/data/remote/remote.dart';
// import 'package:ecommerce_assignment/shared/domain/models/either.dart';
// import 'package:ecommerce_assignment/shared/domain/models/paginated_response.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';
// import 'package:ecommerce_assignment/shared/globals.dart';

import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/paginated_response.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';
import 'package:food_assignment/features/shared/globals.dart';

abstract class CategoryProductDatasource {
  Future<Either<AppException, PaginatedResponse>> fetchCategoryProducts(
      {required int skip, required String categoryId});
}

class CategoryProductRemoteDatasource extends CategoryProductDatasource {
  final NetworkService networkService;
  CategoryProductRemoteDatasource(this.networkService);

  @override
  Future<Either<AppException, PaginatedResponse>> fetchCategoryProducts(
      {required int skip, required String categoryId}) async {
    final response = await networkService.get(
      '/products',
      queryParameters: {
        'size': skip,
        'limit': PRODUCTS_PER_PAGE,
        'category':categoryId
      },
    );

    return response.fold(
          (l) => Left(l),
          (r) {
        final jsonData = r.data;
        if (jsonData == null) {
          return Left(
            AppException(
              identifier: 'fetchPaginatedData',
              statusCode: 0,
              message: 'The data is not in the valid format.',
            ),
          );
        }
        final paginatedResponse =
        PaginatedResponse.fromJson(jsonData, jsonData['data'] ?? []);
        return Right(paginatedResponse);
      },
    );
  }
}
