
import 'package:food_assignment/features/shared/domain/models/common_response.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/review/review_response.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

abstract class ReviewRepository {
  Future<Either<AppException, CommonResponse>> addReview({required Map<String, dynamic> data});
  Future<Either<AppException, ReviewResponse>> getReview({required String data});
}
