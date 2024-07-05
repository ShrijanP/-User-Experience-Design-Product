import 'dart:convert';
import 'dart:io';

// import 'package:ecommerce_assignment/features/shared/constants/endpoint.dart';
// import 'package:ecommerce_assignment/features/shared/domain/models/either.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
// import '../../../../configs/app_configs.dart';
import '../../../../features/shared/data/remote/network_service.dart';
import '../../../../features/shared/domain/models/user/profile_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

import '../../../shared/utils/config.dart';
import '../../../shared/constants/endpoint.dart';
import '../../../shared/exceptions/http_exception.dart';

abstract class ProfileDataSource {
  Future<Either<AppException, ProfileInfoResponse>> getUserInfo();
  Future<Either<AppException, bool>> updateProfile(
      {required String userId, required Map<String, dynamic> data});
  Future<Either<AppException, bool>> uploadProfilePicture(
      {required String image, required String token});
}

class ProfileRemoteDataSource implements ProfileDataSource {
  final NetworkService networkService;

  ProfileRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, ProfileInfoResponse>> getUserInfo() async {
    try {
      final eitherType = await networkService.get(
        CustomerEndpoints.userProfile,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final user = ProfileInfoResponse.fromJson(response.data);

          return Right(user);
        },
      );
    } catch (e) {
      print("PROFILE ERROR:::${e.toString()}");
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nProfileRemoteDataSource.getUser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, bool>> updateProfile(
      {required String userId, required Map<String, dynamic> data}) async {
    try {
      final eitherType = await networkService.put(
        CustomerEndpoints.updateProfile + userId,
        data: data,
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          // final user = ProfileInfoResponse.fromJson(response.data);

          return const Right(true);
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nProfileRemoteDataSource.loginUser',
        ),
      );
    }
  }

  @override
  Future<Either<AppException, bool>> uploadProfilePicture(
      {required String image, required String token}) async {
    try {
      final file = File(image);

      var postUri = Uri.parse("${AppConfigs.baseUrl}users/upload-pp");
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      print("URL PUT::${"${AppConfigs.baseUrl}users/upload-pp"} :: $token");

      var request = http.MultipartRequest("PUT", postUri)
        ..files.add(http.MultipartFile.fromBytes(
            'image', await File.fromUri(Uri.parse(file.path)).readAsBytes(),
            contentType: MediaType('image', 'jpg'), filename: 'image.jpg'))
        ..headers.addAll(headers);

      final response = await request.send();
      final responseData = await response.stream.transform(utf8.decoder).join();

      print("STATUS CODE:::${response.statusCode}");

      if (response.statusCode == 200) {
        print("Upload successful: $responseData");
        return Right(true);
      } else {
        // Handle error
        print("Upload failed: ${response.statusCode} ${response.reasonPhrase}");
        throw AppException(
            message: "Upload failed",
            statusCode: response.statusCode,
            identifier: "");
      }
    } catch (error) {
      print("Error during upload: $error");
      return Left(AppException(
          message: 'Error during upload', statusCode: 500, identifier: ''));
    }
  }
}
