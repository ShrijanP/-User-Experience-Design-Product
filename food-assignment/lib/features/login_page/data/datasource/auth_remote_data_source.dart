import 'dart:convert';

import 'package:food_assignment/features/shared/constants/endpoint.dart';
import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/models.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

import '../../../../features/shared/domain/models/login/login_response.dart';

abstract class LoginUserDataSource {
  Future<Either<AppException, LoginResponse>> loginUser({required User user});
  Future<Either<AppException, User>> registerUser({required User user});
}

class LoginUserRemoteDataSource implements LoginUserDataSource {
  final NetworkService networkService;

  LoginUserRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, LoginResponse>> loginUser({required User user}) async {
    try {
      Map<String, dynamic> loginCred() {
        return {
          'email': user.email,
          'password': user.password,
        };
      }

      final eitherType = await networkService.post(
        CustomerEndpoints.login,
        data: loginCred(),
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final user = LoginResponse.fromJson(response.data);
          // update the token for requests
          networkService.updateHeader(
            {'Authorization': "Bearer ${user.data?.token.toString()}"},
          );

          return Right(user);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, User>> registerUser({required User user}) async {
    try {
      Map<String, dynamic> data = {
        "name": user.firstname,
        "mobile_no": user.contact,
        "email": user.email,
        "password": user.password,
      };

      //   {
      //     "name":"Raj Shrestha 2",
      //   "email": "test@gmail.com",
      //   "password": "password",
      //   "mobile_no": "9841212156"
      // }

      final eitherType = await networkService.post(
        CustomerEndpoints.register,
        data: data,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final user = User.fromJson(response.data);
          // networkService.updateHeader(
          //   {'Authorization': user.token},
          // );

          return Right(user);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser',
        ),
      );
    }
  }
}
