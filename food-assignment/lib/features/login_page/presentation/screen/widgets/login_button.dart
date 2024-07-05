import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/bottom_navigator.dart';
import 'package:food_assignment/features/cart_page/presentation/providers/cart_state_providers.dart';

import '../../../../category/presentation/providers/category_state_providers.dart';
import '../../../../favorite_page/presentation/providers/wishlist_state_providers.dart';
import '../../../../home_page/presentation/providers/dashboard_state_provider.dart';
import '../../../../home_page/presentation/screen/components/colors.dart';
import '../../../../profile_page/presentation/providers/profile_state_provider.dart';
import '../../../../shared/constants/size_config.dart';
import '../../../../shared/domain/providers/shared_preferences_storage_service_provider.dart';
import '../../../../shared/widgets/overlay_notification.dart';
import '../../providers/auth_providers.dart';
import '../../providers/state/auth_state.dart';

class LoginButonColor extends ConsumerStatefulWidget {
  final TextEditingController email;
  final TextEditingController password;
  const LoginButonColor({Key? key, required this.email, required this.password})
      : super(key: key);

  @override
  ConsumerState createState() => _LoginButonColorState();
}

class _LoginButonColorState extends ConsumerState<LoginButonColor> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authStateNotifierProvider);
    ref.listen(
      authStateNotifierProvider.select((value) => value),
      ((previous, next) {
        //show Snackbar on failure
        if (next is Failure) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text(next.exception.message.toString())));
          showTopOverlayNotificationError(
              title: next.exception.message.toString());
        } else if (next is Success) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
          ref
              .read(storageServiceProvider)
              .set('email', widget.email.toString());
          ref.watch(myWishlistStateNotifierProvider.notifier).fetchWishlist();
          ref.watch(myCartStateNotifierProvider.notifier).fetchMyCart();
          ref.watch(profileNotifierProvider.notifier).getUserProfile();
          ref.watch(categoryStateNotifierProvider.notifier).fetchCategory();
          ref.watch(dashboardNotifierProvider.notifier).fetchProducts();
        }
      }),
    );

    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.screenWidth! / 20.55,
          SizeConfig.screenHeight! / 7.59,
          SizeConfig.screenWidth! / 20.55,
          SizeConfig.screenHeight! / 45.54),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0, 4), blurRadius: 5.0)
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.0, 1.0],
            colors: [
              buttonColor,
              lightColor,
            ],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: state.maybeMap(
          loading: (_) => const Center(child: CircularProgressIndicator()),
          orElse: () => ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              minimumSize: MaterialStateProperty.all(Size(
                  SizeConfig.screenWidth! / 1.37,
                  SizeConfig.screenHeight! / 13.66)),
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            onPressed: () {
              ref.read(authStateNotifierProvider.notifier).loginUser(
                  widget.email.text.toString(),
                  widget.password.text.toString());

              ref
                  .read(storageServiceProvider)
                  .set('email', widget.email.text.toString());
              ref
                  .read(storageServiceProvider)
                  .set('password', widget.password.text.toString());
            },
            child: Text(
              "LOGIN",
              style: TextStyle(
                fontSize: SizeConfig.screenHeight! / 42.68,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),

              /// 16
            ),
          ),
        ),
      ),
    );
  }
}
