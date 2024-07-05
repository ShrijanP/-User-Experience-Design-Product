import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/login/login_response.dart';
import 'package:food_assignment/features/shared/domain/models/models.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

abstract class UserRepository {
  Future<Either<AppException, LoginResponse>> fetchUser();
  Future<bool> saveUser({required LoginResponse user});
  Future<bool> deleteUser();
  Future<bool> hasUser();
}
