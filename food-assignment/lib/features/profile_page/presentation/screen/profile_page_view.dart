import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/profile_page/presentation/screen/widgets/edit_profile.dart';
import 'package:food_assignment/features/profile_page/presentation/screen/widgets/top_custom_shape.dart';
import 'package:food_assignment/features/profile_page/presentation/screen/widgets/user_sections.dart';

import '../../../login_page/presentation/screen/login_page_view.dart';
import '../../../services/user_cache_service/domain/providers/user_cache_provider.dart';
import '../../../shared/constants/size_config.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';
// import 'package:food_assignment/features/profile_page/widgets/top_custom_shape.dart';
// import 'package:food_assignment/features/profile_page/widgets/user_sections.dart';

class ProfilePageView extends ConsumerStatefulWidget {
  const ProfilePageView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends ConsumerState<ProfilePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopCustomShape(),
            SizedBox(
              height: SizeConfig.screenHeight! / 34.15,
            ),
            UserSection(
              icon_name: Icons.account_circle,
              section_text: "My information",
              onTab: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CompleteProfileForm()));
              },
            ),
            UserSection(
              icon_name: Icons.password_sharp,
              section_text: "Update Password",
              onTab: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CompleteProfileForm()));
              },
            ),
            // UserSection(
            //   icon_name: Icons.shopping_basket,
            //   section_text: "Past orders",
            //   onTab: () {},
            // ),
            // UserSection(
            //   icon_name: Icons.location_city,
            //   section_text: "Address information",
            //   onTab: () {},
            // ),
            // UserSection(
            //   icon_name: Icons.wallet_giftcard,
            //   section_text: "Coupons",
            //   onTab: () {},
            // ),
            UserSection(
              icon_name: Icons.logout_rounded,
              section_text: "Log out",
              onTab: () async {
                await ref.read(userLocalRepositoryProvider).deleteUser();

                if (context.mounted)
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LoginPageView()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
