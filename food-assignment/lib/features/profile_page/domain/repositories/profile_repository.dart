import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';
import '../../../../features/shared/domain/models/user/profile_info_model.dart';

abstract class ProfileRepository {
  Future<Either<AppException, ProfileInfoResponse>> getUserInfo();
  Future<Either<AppException, bool>> updateProfile(
      {required String userId, required Map<String, dynamic> data});
  Future<Either<AppException, bool>> uploadProfilePicture(
      {required String image, required String token});
}
