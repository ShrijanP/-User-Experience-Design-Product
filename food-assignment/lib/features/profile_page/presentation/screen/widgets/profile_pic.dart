import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../shared/utils/config.dart';
import '../../../../shared/widgets/overlay_notification.dart';
import '../../../../services/user_cache_service/domain/providers/current_user_provider.dart';
import '../../../../shared/constants/size_config.dart';
import '../../providers/profile_state_provider.dart';
import '../../providers/state/profile_state.dart';

class ProfilePic extends ConsumerWidget {
  String? image;
  ProfilePic({
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider).asData?.value;
    String? userToken = currentUser?.data?.token.toString();
    ref.watch(uploadProfilePictureStateNotifierProvider);
    ref.listen(
      uploadProfilePictureStateNotifierProvider.select((value) => value),
      ((previous, next) {
        if (next is Failure) {
          showTopOverlayNotificationError(
              title: next.exception.message.toString());
        } else if (next is Success) {
          ref.watch(profileNotifierProvider.notifier).getUserProfile();
          showTopOverlayNotification(title: "Profile Image Updated!!");
        }
      }),
    );

    return _buildBody(context, ref, userToken.toString(), image.toString());
  }

  Widget _buildBody(
      BuildContext context, WidgetRef ref, String userToken, String image) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: SizeConfig.screenHeight! / 4.88,
            width: SizeConfig.screenWidth! / 2.93,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Colors.grey,
                    width: SizeConfig.screenWidth! / 250),
                color: Colors.white,
                image: DecorationImage(
                  image: Image.network(
                    AppConfigs.imageUrl + image,
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ).image,
                )),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) =>
                          bottomSheet(context, ref, userToken.toString()));
                },
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source,
      WidgetRef ref, String token) async {
    PickedFile? _imageFile;
    var selected =
        await ImagePicker().pickImage(source: source, imageQuality: 10);

    if (selected != null) {
      _imageFile = PickedFile(selected.path);

      ref
          .read(uploadProfilePictureStateNotifierProvider.notifier)
          .uploadProfilePicture(_imageFile.path.toString(), token.toString());
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No image selected")));
      }
    }
  }

  Widget bottomSheet(BuildContext context, WidgetRef ref, String token) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            "choose photo",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.camera, color: Colors.red),
                onPressed: () async {
                  _pickImage(context, ImageSource.camera, ref, token);
                  Navigator.of(context, rootNavigator: true).pop();
                },
                label: const Text("Camera"),
              ),
              TextButton.icon(
                icon: const Icon(Icons.image, color: Colors.green),
                onPressed: () {
                  _pickImage(context, ImageSource.gallery, ref, token);
                  Navigator.of(context, rootNavigator: true).pop();
                },
                label: const Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
