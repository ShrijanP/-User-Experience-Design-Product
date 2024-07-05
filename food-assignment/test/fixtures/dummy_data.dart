import 'package:food_assignment/features/shared/domain/models/login/login_response.dart';
import 'package:food_assignment/features/shared/domain/models/response.dart';
import 'package:food_assignment/features/shared/domain/models/user/user_model.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

import 'data/user_map.dart';

final AppException ktestAppException =
    AppException(message: '', statusCode: 0, identifier: '');

final User ktestUser = User.fromJson(const {});

final User ktestUserFromMap = User.fromJson(ktestUserMap);

final Response ktestUserResponse =
    Response(statusMessage: 'message', statusCode: 1, data: {});


final LoginResponse ktestLoginUser = LoginResponse.fromJson(const {});

final LoginResponse ktestLoginUserFromMap = LoginResponse.fromJson(ktestUserMap);

final Response ktestLoginUserResponse =
Response(statusMessage: 'message', statusCode: 1, data: {});
