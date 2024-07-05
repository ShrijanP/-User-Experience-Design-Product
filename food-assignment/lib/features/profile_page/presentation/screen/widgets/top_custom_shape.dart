import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/profile_page/presentation/screen/widgets/profile_pic.dart';

import '../../../../home_page/presentation/screen/components/colors.dart';
import '../../../../shared/constants/size_config.dart';
import '../../../../shared/domain/models/user/profile_info_model.dart';
import '../../providers/profile_state_provider.dart';
import '../components/CustomShape.dart';
// import 'package:food_assignment/features/home_page/components/colors.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';
// import 'package:food_assignment/features/profile_page/components/CustomShape.dart';

class TopCustomShape extends ConsumerStatefulWidget {
  const TopCustomShape({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _TopCustomShapeState();
}

class _TopCustomShapeState extends ConsumerState<TopCustomShape> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileNotifierProvider);
    return SizedBox(
      height: SizeConfig.screenHeight! / 2.84,
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomShape(),
            child: Container(
              height: SizeConfig.screenHeight! / 4.56,
              color: buttonColor,
            ),
          ),
          state.when(
              initial: () => Container(),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (failure, data) => _buildBody(context, ref, data),
              success: (data) => _buildBody(context, ref, data)),
        ],
      ),
    );
  }

  Widget _buildBody(
      BuildContext context, WidgetRef ref, ProfileInfoResponse data) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ProfilePic(image: data.data!.image),
          data.data!.name == null
              ? Container()
              : Text(
                  "${data.data!.name}",
                  style: const TextStyle(fontSize: 22),
                ),
          SizedBox(
            height: SizeConfig.screenHeight! / 136.6,
          ),
          Text(
            data.data!.email.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.w400, color: Colors.black45),
          ),
          Text(
            data.data!.mobile_no.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.w400, color: Colors.black45),
          )
        ],
      ),
    );
  }
}
