import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/home_page/presentation/screen/home_page_view.dart';
import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/splash/presentation/provider/splash_provider.dart';
// import 'package:food_assignment/features/login_page/presentation/login_page_view.dart';
import 'package:food_assignment/features/start_page/start_page_view.dart';

import '../../bottom_navigator.dart';
import '../../cart_page/presentation/providers/cart_state_providers.dart';
import '../../category/presentation/providers/category_state_providers.dart';
import '../../favorite_page/presentation/providers/wishlist_state_providers.dart';
import '../../home_page/presentation/providers/dashboard_state_provider.dart';
import '../../login_page/presentation/screen/login_page_view.dart';
import '../../profile_page/presentation/providers/profile_state_provider.dart';
import '../../services/user_cache_service/domain/providers/current_user_provider.dart';
import '../../services/user_cache_service/domain/providers/user_cache_provider.dart';
import '../../shared/constants/size_config.dart';
import '../../shared/domain/providers/dio_network_service_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Future.delayed(Duration(seconds: 4), () {
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPageView()));
  //   });
  // }

  late NetworkService networkService;

  @override
  void initState() {
    super.initState();

    networkService = ref.read(networkServiceProvider);

    Future.delayed(const Duration(seconds: 2), () async {
      final isUserLoggedIn = await ref.read(userLoginCheckProvider.future);

      if (!mounted) return;

      if(isUserLoggedIn){
        var userTokenCheck = await ref.read(currentUserProvider.future);

        print("userTokenCheck: ${userTokenCheck?.toJson()}");

        networkService.updateHeader(
          {'Authorization': "Bearer ${userTokenCheck?.data?.token}"},
        );

        print(
            "USER LOGGED IN::${isUserLoggedIn}::::${userTokenCheck?.data?.token}");

        if (isUserLoggedIn) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyHomePage()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPageView()));
        }

        ref.watch(myWishlistStateNotifierProvider.notifier).fetchWishlist();
        ref.watch(myCartStateNotifierProvider.notifier).fetchMyCart();
        ref.watch(profileNotifierProvider.notifier).getUserProfile();
        ref.watch(categoryStateNotifierProvider.notifier).fetchCategory();
        ref.watch(dashboardNotifierProvider.notifier).fetchProducts();

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/main/splashscreen.gif"),
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
