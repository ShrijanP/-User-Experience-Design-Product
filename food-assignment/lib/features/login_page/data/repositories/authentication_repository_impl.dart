import 'package:food_assignment/features/login_page/data/datasource/auth_remote_data_source.dart';
import 'package:food_assignment/features/login_page/domain/repositories/auth_repository.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/user/user_model.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

import '../../../../features/shared/domain/models/login/login_response.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final LoginUserDataSource dataSource;

  AuthenticationRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, LoginResponse>> loginUser({required User user}) {
    return dataSource.loginUser(user: user);
  }

  @override
  Future<Either<AppException, User>> registerUser({required User user}) {
    return dataSource.registerUser(user: user);
  }
}
