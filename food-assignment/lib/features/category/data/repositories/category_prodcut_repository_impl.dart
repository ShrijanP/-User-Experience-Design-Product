// import 'package:ecommerce_assignment/shared/domain/models/either.dart';
// import 'package:ecommerce_assignment/shared/domain/models/paginated_response.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';

import 'package:food_assignment/features/shared/domain/models/paginated_response.dart';

import '../../../shared/domain/models/either.dart';
import '../../../shared/exceptions/http_exception.dart';
import '../../domain/repositories/category_product_repository.dart';
import '../datasource/category_product_remote_data_source.dart';

class CategoryProductRepositoryImpl extends CategoryProductRepository {
  final CategoryProductDatasource categoryProductDatasource;
  CategoryProductRepositoryImpl(this.categoryProductDatasource);

  @override
  Future<Either<AppException, PaginatedResponse>> fetchCategoryProducts(
      {required int skip, required String categoryId}) {
    return categoryProductDatasource.fetchCategoryProducts(skip: skip, categoryId: categoryId);
  }
}
