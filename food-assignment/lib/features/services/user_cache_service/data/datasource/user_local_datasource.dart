import 'dart:convert';

import 'package:food_assignment/features/shared/data/local/storage_service.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/user/user_model.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';
import 'package:food_assignment/features/shared/globals.dart';

import '../../../../shared/domain/models/login/login_response.dart';

abstract class UserDataSource {
  String get storageKey;

  Future<Either<AppException, LoginResponse>> fetchUser();
  Future<bool> saveUser({required LoginResponse user});
  Future<bool> deleteUser();
  Future<bool> hasUser();
}

class UserLocalDatasource extends UserDataSource {
  UserLocalDatasource(this.storageService);

  final StorageService storageService;

  @override
  String get storageKey => USER_LOCAL_STORAGE_KEY;

  @override
  Future<Either<AppException, LoginResponse>> fetchUser() async {
    final data = await storageService.get(storageKey);
    if (data == null) {
      return Left(
        AppException(
          identifier: 'UserLocalDatasource',
          statusCode: 404,
          message: 'User not found',
        ),
      );
    }
    final userJson = jsonDecode(data.toString());

    return Right(LoginResponse.fromJson(userJson));
  }

  @override
  Future<bool> saveUser({required LoginResponse user}) async {
    return await storageService.set(storageKey, jsonEncode(user.toJson()));
  }

  @override
  Future<bool> deleteUser() async {
    await storageService.clear();
    return await storageService.remove(storageKey);
  }

  @override
  Future<bool> hasUser() async {
    return await storageService.has(storageKey);
  }
}
