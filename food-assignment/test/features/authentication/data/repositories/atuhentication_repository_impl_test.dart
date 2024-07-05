import 'package:flutter_test/flutter_test.dart';
import 'package:food_assignment/features/login_page/data/datasource/auth_remote_data_source.dart';
import 'package:food_assignment/features/login_page/data/repositories/authentication_repository_impl.dart';
import 'package:food_assignment/features/login_page/domain/repositories/auth_repository.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/login/login_response.dart';
import 'package:food_assignment/features/shared/domain/models/user/user_model.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/dummy_data.dart';

void main() {
  late LoginUserDataSource mockLoginUserDataSource;
  late AuthenticationRepository authenticationRepository;
  setUpAll(
    () {
      registerFallbackValue(ktestUser);
      mockLoginUserDataSource = MockLoginUserDataSource();
      authenticationRepository =
          AuthenticationRepositoryImpl(mockLoginUserDataSource);
    },
  );
  group(
    'Authentication Repository Test\n',
    () {
      test(
        'login user should return User when the login is successful',
        () async {
          when(
            () => mockLoginUserDataSource.loginUser(user: any(named: 'user')),
          ).thenAnswer(
            (_) async => Right<AppException, LoginResponse>(ktestLoginUser),
          );

          final response =
              await authenticationRepository.loginUser(user: ktestUser);

          expect(response.isRight(), true);
        },
      );
      test(
        'login user should return AppException on Login failure',
        () async {
          when(
            () => mockLoginUserDataSource.loginUser(user: any(named: 'user')),
          ).thenAnswer(
            (_) async => Left<AppException, LoginResponse>(ktestAppException),
          );

          final response =
              await authenticationRepository.loginUser(user: ktestUser);

          expect(response.isLeft(), true);
        },
      );
    },
  );
}

class MockLoginUserDataSource extends Mock implements LoginUserDataSource {}
