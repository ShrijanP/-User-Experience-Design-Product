import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/start_page/start_page_view.dart';
import 'package:food_assignment/features/splash/presentation/splash_screen.dart';
import 'package:food_assignment/features/start_page/start_page_view.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:overlay_support/overlay_support.dart';

import 'features/shared/data/local/hive_config.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/splash/presentation/provider/splash_provider.dart';

// void main() {
//   runApp(mainCommon());
// }

void main() => mainCommon();

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await HiveUtils.init();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const ProviderScope(
    observers: [
      // Observers(),
    ],
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUserLoggedIn = ref.watch(userLoginCheckProvider.future);
    return OverlaySupport.global(
      child: KhaltiScope(
          publicKey: 'test_public_key_761aff13c5a14fafa192fc609dcd9749',
          builder: (context, GlobalKey<NavigatorState> nakKey) {
            return MaterialApp(
              navigatorKey: nakKey,
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('ne', 'NP'),
              ],
              localizationsDelegates: const [
                KhaltiLocalizations.delegate,
              ],
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.orange,
              ),
              home: FutureBuilder(
                future: isUserLoggedIn,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SplashScreen();
                  } else {
                    final bool loggedIn = snapshot.data ?? false;
                    return loggedIn
                        ? const SplashScreen()
                        : const StartPageView();
                  }
                },
              ),
            );
          }),
    );
  }
}
