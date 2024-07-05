import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/start_page/widgets/login_button_widget.dart';
import 'package:food_assignment/features/start_page/widgets/register_button_widget.dart';

import '../cart_page/presentation/providers/cart_state_providers.dart';
import '../favorite_page/presentation/providers/wishlist_state_providers.dart';
import '../home_page/presentation/providers/dashboard_state_provider.dart';
import '../home_page/presentation/screen/home_page_view.dart';
import '../login_page/presentation/screen/login_page_view.dart';
import '../login_page/presentation/screen/widgets/text_title.dart';
import '../services/user_cache_service/domain/providers/current_user_provider.dart';
import '../shared/constants/size_config.dart';
import '../shared/domain/providers/dio_network_service_provider.dart';
import '../splash/presentation/provider/splash_provider.dart';

class StartPageView extends ConsumerStatefulWidget {
  const StartPageView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _StartPageViewState();
}

class _StartPageViewState extends ConsumerState<StartPageView> {
  late NetworkService networkService;

  @override
  void initState() {
    super.initState();

    networkService = ref.read(networkServiceProvider);

    Future.delayed(const Duration(seconds: 2), () async {
      final isUserLoggedIn = await ref.read(userLoginCheckProvider.future);

      var userTokenCheck = await ref.read(currentUserProvider.future);

      print("userTokenCheck: ${userTokenCheck?.toJson()}");

      networkService.updateHeader(
        {'Authorization': "Bearer ${userTokenCheck?.data?.token}"},
      );

      print(
          "USER LOGGED IN::${isUserLoggedIn}::::${userTokenCheck?.data?.token}");

      final route =
          isUserLoggedIn ? const HomePageView() : const LoginPageView();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => route));

      ref.watch(myWishlistStateNotifierProvider.notifier).fetchWishlist();
      ref.watch(myCartStateNotifierProvider.notifier).fetchMyCart();
      // ref.watch(profileNotifierProvider.notifier).getUserProfile();
      // ref.watch(categoryStateNotifierProvider.notifier).fetchCategory();
      ref.watch(dashboardNotifierProvider.notifier).fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            height: SizeConfig.screenHeight! / 2.732,

            /// 250.0
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/main/bg.png'), fit: BoxFit.fill)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.screenWidth! / 1.83,

                /// 225.0
                height: SizeConfig.screenHeight! / 5.174,

                /// 132.0
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/main/logo.png",
                        ),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    SizeConfig.screenHeight! / 68.3,

                    /// 10.0
                    0,
                    SizeConfig.screenHeight! / 11.38

                    /// 60.0
                    ),
                child: Column(children: [
                  Center(
                    child: TextTitle(
                      title: "WELCOME",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth! / 10.28,
                        vertical: SizeConfig.screenHeight! / 136.6),

                    /// 40.0 - 5.0
                    child: Center(
                      child: Text(
                        "Welcome to the world of healthy nutrients, here we are for you.",
                        style: TextStyle(color: Colors.white60),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ]),
              ),
              LoginButton(),
              RegisterButtonWidget()
            ],
          )
        ],
      ),
    );
  }
}
