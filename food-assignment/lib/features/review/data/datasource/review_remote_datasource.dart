import 'dart:convert';

import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/shared/domain/models/common_response.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/review/review_response.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';
import '../../../shared/constants/endpoint.dart';

abstract class ReviewDataSource {
  Future<Either<AppException, CommonResponse>> addReview(
      {required Map<String, dynamic> data});

  Future<Either<AppException, ReviewResponse>> getReview(
      {required String data});
}

class ReviewRemoteDataSource implements ReviewDataSource {
  final NetworkService networkService;

  ReviewRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, CommonResponse>> addReview(
      {required Map<String, dynamic> data}) async {
    try {
      final eitherType = await networkService.post(
        CustomerEndpoints.addReview,
        data: data,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final user = CommonResponse.fromJson(response.data);

          return Right(user);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nReviewRemoteDataSource.loginUser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, ReviewResponse>> getReview(
      {required String data}) async {
    try {
      final eitherType = await networkService.get(
        '${CustomerEndpoints.addReview}/$data',
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final user = ReviewResponse.fromJson(response.data);

          return Right(user);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nReviewRemoteDataSource.getReview',
        ),
      );
    }
  }
}
