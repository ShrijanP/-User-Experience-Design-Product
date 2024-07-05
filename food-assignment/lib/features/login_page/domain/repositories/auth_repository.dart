import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/models.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

import '../../../../features/shared/domain/models/login/login_response.dart';

abstract class AuthenticationRepository {
  Future<Either<AppException, LoginResponse>> loginUser({required User user});
  Future<Either<AppException, User>> registerUser({required User user});
}
