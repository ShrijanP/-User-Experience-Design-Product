import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/profile_page/presentation/providers/state/profile_state.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';
import 'package:hive/hive.dart';
import '../../../../shared/constants/endpoint.dart';
import '../../../../shared/data/local/hive_config.dart';
import '../../../../shared/domain/models/user/profile_info_model.dart';
import '../../../domain/repositories/profile_repository.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository profileRepository;

  ProfileNotifier(
    this.profileRepository,
  ) : super(const ProfileState.initial());

  Future<void> getUserProfile() async {
    Box box = HiveUtils.box;
    state = const ProfileState.loading();

    final response = await profileRepository.getUserInfo();

    print("HIT PROFILE API::${response}");

    response.fold(
      (failure) => handleFailure(failure, box),
      (data) => handleSuccess(data, box),
    );
  }

  Future<void> handleFailure(AppException failure, Box box) async {
    ProfileInfoResponse? response = await getCachedProfileInfo(box);
    state = ProfileState.failure(failure, response!);
  }

  Future<void> handleSuccess(ProfileInfoResponse data, Box box) async {
    box.put(CustomerEndpoints.userProfile, jsonEncode(data));
    state = ProfileState.success(data);
  }

  Future<ProfileInfoResponse?> getCachedProfileInfo(Box box) async {
    ProfileInfoResponse res;
    dynamic response = await box.get(CustomerEndpoints.userProfile);

    //decode
    dynamic responseDecode = jsonDecode(response);

    print("RESPONSE FROM CACHE::${responseDecode.runtimeType}");

    res = ProfileInfoResponse.fromJson(responseDecode);

    print("USER PROFILE DATA::${response.toString()}}");

    return res;
  }

  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> data) async {
    state = const ProfileState.loading();
    final response =
        await profileRepository.updateProfile(userId: userId, data: data);

    state = await response.fold(
      (failure) => ProfileState.failure(failure, ProfileInfoResponse()),
      (user) async {
        getUserProfile();
        return ProfileState.success(ProfileInfoResponse(success: user));
      },
    );
  }

  Future<void> uploadProfilePicture(String image, String token) async {
    state = const ProfileState.loading();
    final response =
    await profileRepository.uploadProfilePicture(image: image, token: token);

    state = await response.fold(
          (failure) => ProfileState.failure(failure, ProfileInfoResponse()),
          (user) async {
        return ProfileState.success(ProfileInfoResponse(success: user));
      },
    );
  }
}
