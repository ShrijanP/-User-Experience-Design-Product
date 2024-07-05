// import 'package:ecommerce_assignment/features/profile_page/data/datasource/auth_remote_data_source.dart';
// import 'package:ecommerce_assignment/shared/domain/models/either.dart';
// import 'package:ecommerce_assignment/shared/domain/models/user/profile_info_model.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import '../../../shared/domain/models/user/profile_info_model.dart';
import '../../../shared/exceptions/http_exception.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasource/profile_remote_data_source.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileDataSource dataSource;

  ProfileRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, ProfileInfoResponse>> getUserInfo() {
    return dataSource.getUserInfo();
  }

  @override
  Future<Either<AppException, bool>> updateProfile(
      {required String userId, required Map<String, dynamic> data}) {
    return dataSource.updateProfile(userId: userId, data: data);
  }

  @override
  Future<Either<AppException, bool>> uploadProfilePicture(
      {required String image, required String token}) {
    return dataSource.uploadProfilePicture( image: image, token: token);
  }
}
