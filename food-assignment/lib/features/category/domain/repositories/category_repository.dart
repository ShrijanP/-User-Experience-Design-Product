// import 'package:ecommerce_assignment/shared/domain/models/category/category_response.dart';
// import 'package:ecommerce_assignment/shared/domain/models/either.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';


import 'package:food_assignment/features/shared/domain/models/category/category_response.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

abstract class CategoryRepository {
  Future<Either<AppException, CategoryResponse>> fetchCategory();
}
