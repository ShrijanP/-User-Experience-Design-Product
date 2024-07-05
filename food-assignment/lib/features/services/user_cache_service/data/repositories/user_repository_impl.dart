import 'package:food_assignment/features/services/user_cache_service/data/datasource/user_local_datasource.dart';
import 'package:food_assignment/features/services/user_cache_service/domain/repositories/user_cache_repository.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/login/login_response.dart';
import 'package:food_assignment/features/shared/domain/models/user/user_model.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl(this.dataSource);

  final UserDataSource dataSource;

  @override
  Future<bool> deleteUser() {
    return dataSource.deleteUser();
  }

  @override
  Future<Either<AppException, LoginResponse>> fetchUser() {
    return dataSource.fetchUser();
  }

  @override
  Future<bool> saveUser({required LoginResponse user}) {
    return dataSource.saveUser(user: user);
  }

  @override
  Future<bool> hasUser() {
    return dataSource.hasUser();
  }
}
