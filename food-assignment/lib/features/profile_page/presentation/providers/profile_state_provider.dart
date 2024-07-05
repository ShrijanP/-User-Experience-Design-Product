// import 'package:ecommerce_assignment/features/profile/presentation/providers/state/profile_notifier.dart';
// import 'package:ecommerce_assignment/features/profile/presentation/providers/state/profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/profile_page/presentation/providers/state/profile_notifier.dart';
import 'package:food_assignment/features/profile_page/presentation/providers/state/profile_state.dart';

import '../../domain/providers/profile_provider.dart';

final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return ProfileNotifier(repository)..getUserProfile();
});

final editProfileStateNotifierProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>(
  (ref) {
    final repository = ref.watch(profileRepositoryProvider);
    return ProfileNotifier(repository);
  },
);

final uploadProfilePictureStateNotifierProvider =
StateNotifierProvider<ProfileNotifier, ProfileState>(
      (ref) {
    final repository = ref.watch(profileRepositoryProvider);
    return ProfileNotifier(repository);
  },
);
