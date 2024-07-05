// import 'package:food_assignment/shared/domain/models/either.dart';
// import 'package:food_assignment/shared/domain/models/response.dart';
// import 'package:food_assignment/shared/exceptions/http_exception.dart';

import '../../domain/models/either.dart';
import '../../domain/models/response.dart';
import '../../exceptions/http_exception.dart';

abstract class NetworkService {
  String get baseUrl;

  Map<String, Object> get headers;

  void updateHeader(Map<String, dynamic> data);

  Future<Either<AppException, Response>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  Future<Either<AppException, Response>> post(
    String endpoint, {
    Map<String, dynamic>? data,
  });

  Future<Either<AppException, Response>> put(
      String endpoint, {
        Map<String, dynamic>? data,
      });
}
