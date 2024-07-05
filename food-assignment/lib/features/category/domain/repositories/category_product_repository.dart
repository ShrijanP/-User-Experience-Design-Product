// import 'package:ecommerce_assignment/shared/domain/models/either.dart';
// import 'package:ecommerce_assignment/shared/domain/models/paginated_response.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';

import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/paginated_response.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

abstract class CategoryProductRepository {
  Future<Either<AppException, PaginatedResponse>> fetchCategoryProducts(
      {required int skip, required String categoryId});
}
