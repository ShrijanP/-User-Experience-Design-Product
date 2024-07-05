// import 'package:food_assignment/shared/domain/models/either.dart';
// import 'package:food_assignment/shared/exceptions/http_exception.dart';

import 'package:food_assignment/features/shared/domain/models/either.dart';

import '../../exceptions/http_exception.dart';

class Response {
  final int statusCode;
  final String? statusMessage;
  final dynamic data;

  Response(
      {required this.statusCode, this.statusMessage, this.data = const {}});
  @override
  String toString() {
    return 'statusCode=$statusCode\nstatusMessage=$statusMessage\n data=$data';
  }
}

extension ResponseExtension on Response {
  Right<AppException, Response> get toRight => Right(this);
}
