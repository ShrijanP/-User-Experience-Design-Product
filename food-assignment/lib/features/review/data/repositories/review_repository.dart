// import 'package:ecommerce_assignment/shared/domain/models/common_response.dart';
// import 'package:ecommerce_assignment/shared/domain/models/either.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';
//
// import '../../../../shared/domain/models/review/review_response.dart';
import 'package:food_assignment/features/shared/domain/models/common_response.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/review/review_response.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

import '../../domain/repositories/review_repository.dart';
import '../datasource/review_remote_datasource.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  final ReviewDataSource dataSource;

  ReviewRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, CommonResponse>> addReview({required Map<String, dynamic> data}) {
    return dataSource.addReview(data: data);
  }

  @override
  Future<Either<AppException, ReviewResponse>> getReview({required String data}) {
    return dataSource.getReview(data: data);
  }
}
