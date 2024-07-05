import 'dart:convert';
import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

import '../../../shared/constants/endpoint.dart';
import '../../../shared/domain/models/wishlist/my_wishlist_response.dart';

abstract class WishlistDataSource {
  Future<Either<AppException, String>> addWishlist({required String id});

  Future<Either<AppException, WishlistResponse>> fetchWishlist();
}

class WishlistRemoteDataSource implements WishlistDataSource {
  final NetworkService networkService;

  WishlistRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, String>> addWishlist({required String id}) async {
    try {
      final eitherType = await networkService.post(
        CustomerEndpoints.wishlist + id,
        data: null,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          // final message = response.data.
          print("WISHLIST RESPONSE: $response");
          return Right("user");
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

  @override
  Future<Either<AppException, WishlistResponse>> fetchWishlist() async {
    try {
      final eitherType = await networkService.get(
        "/wishlist",
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          // final message = response.data.
          final data = WishlistResponse.fromJson(response.data);
          return Right(data);
          print("WISHLIST RESPONSE: ${response.data}");
          return Right(response.data);
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
