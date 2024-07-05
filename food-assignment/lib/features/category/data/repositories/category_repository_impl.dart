
// import 'package:ecommerce_assignment/shared/domain/models/either.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';
// import '../../../../shared/domain/models/category/category_response.dart';
// import '../../../../shared/domain/models/order/my_order_response.dart';
// import '../../../../shared/domain/models/paginated_response.dart';
import '../../../shared/domain/models/category/category_response.dart';
import '../../../shared/domain/models/either.dart';
import '../../../shared/exceptions/http_exception.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasource/category_remote_data_source.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDataSource dataSource;

  CategoryRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, CategoryResponse>> fetchCategory() {
    return dataSource.fetchCategory();
  }
}
