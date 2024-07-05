import 'dart:convert';
import 'package:food_assignment/features/shared/constants/endpoint.dart';
import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/shared/domain/models/cart/my_cart_response.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';
import '../../../../features/shared/domain/models/cart/add_to_cart_response.dart';
import '../../../../features/shared/domain/models/common_response.dart';

abstract class CartDataSource {
  Future<Either<AppException, AddToCartResponse>> addToCart(
      {required Map<String, dynamic> requestData});
  Future<Either<AppException, MyCartResponse>> fetchMyCart();
  Future<Either<AppException, CommonResponse>> removeCart(
      {required Map<String, dynamic> requestData});

  Future<Either<AppException, CommonResponse>> checkOut(
      {required String requestData, required String id});
}

class CartRemoteDataSource implements CartDataSource {
  final NetworkService networkService;

  CartRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, AddToCartResponse>> addToCart(
      {required Map<String, dynamic> requestData}) async {
    try {
      final eitherType = await networkService.post(
        CustomerEndpoints.addToCart,
        data: requestData,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final user = AddToCartResponse.fromJson(response.data);
          return Right(user);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nCartRemoteDataSource.addToCart',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, MyCartResponse>> fetchMyCart() async {
    try {
      final eitherType = await networkService.get(CustomerEndpoints.myCart);
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final data = MyCartResponse.fromJson(response.data);
          return Right(data);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nCartRemoteDataSource.fetchMyCart',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, CommonResponse>> removeCart(
      {required Map<String, dynamic> requestData}) async {
    try {
      final eitherType = await networkService.put(
        CustomerEndpoints.removeCart,
        data: requestData,
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
          identifier: '${e.toString()}\nCartRemoteDataSource.removeCart',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, CommonResponse>> checkOut(
      {required String requestData, required String id}) async {
    try {
      Map<String, dynamic> data = {"shipping_address": requestData};

      final eitherType = await networkService.put(
        CustomerEndpoints.checkOut + id,
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
          identifier: '${e.toString()}\nCartRemoteDataSource.checkOut',
        ),
      );
    }
  }
}
