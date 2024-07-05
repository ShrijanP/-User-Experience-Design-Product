// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:food_assignment/features/login_page/presentation/screen/widgets/login_button.dart';
// import 'package:food_assignment/features/login_page/presentation/screen/widgets/text_field_widget/text_field_input.dart';
// import 'package:food_assignment/features/shared/widgets/overlay_notification.dart';
// import '../../../home_page/presentation/screen/components/colors.dart';
// import '../../../shared/constants/size_config.dart';
// import '../../../shared/domain/providers/shared_preferences_storage_service_provider.dart';
// import '../providers/auth_providers.dart';
// import 'widgets/logo.dart';
// import 'widgets/text_signup.dart';
// import 'package:local_auth/local_auth.dart';

// class LoginPageView extends ConsumerStatefulWidget {
//   const LoginPageView({Key? key}) : super(key: key);

//   @override
//   ConsumerState createState() => _LoginPageViewState();
// }

// class _LoginPageViewState extends ConsumerState<LoginPageView> {
//   bool passwordObscure = true;
//   TextEditingController email = TextEditingController();
//   TextEditingController password = TextEditingController();

//   final auth = LocalAuthentication();
//   String authorized = " not authorized";
//   bool _canCheckBiometric = false;

//   bool _showFingerScanButton = false;
//   late List<BiometricType> _availableBiometric;

//   Future<void> _authenticate() async {
//     bool authenticated = false;

//     try {
//       authenticated = await auth.authenticate(
//         localizedReason: "Scan your finger to authenticate",
//       );
//     } on PlatformException catch (e) {
//       print(e);
//     }

//     setState(() {
//       authorized =
//           authenticated ? "Authorized success" : "Failed to authenticate";
//       print(authorized);
//       if (authenticated) {
//         _submit();
//       } else {
//         showTopOverlayNotificationError(title: "Not authenticated");
//         // ScaffoldMessenger.of(context)
//         //     .showSnackBar(const SnackBar(content: Text("Not authenticated")));
//       }
//     });
//   }

//   void _submit() async {
//     Object? usernameLocal = await ref.read(storageServiceProvider).get('email');
//     Object? passwordLocal =
//         await ref.read(storageServiceProvider).get('password');

//     print("usernameLocal:::${usernameLocal}");
//     print("passwordLocal:::${passwordLocal}");

//     ref
//         .read(authStateNotifierProvider.notifier)
//         .loginUser(usernameLocal.toString(), passwordLocal.toString());
//   }

//   Future<void> _checkBiometric() async {
//     bool canCheckBiometric = false;

//     try {
//       canCheckBiometric = await auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       print(e);
//     }

//     if (!mounted) return;

//     setState(() {
//       _canCheckBiometric = canCheckBiometric;
//     });
//   }

//   Future checkUsername() async {
//     _showFingerScanButton = await ref.read(storageServiceProvider).has('email');
//   }

//   Future _getAvailableBiometric() async {
//     List<BiometricType> availableBiometric = [];

//     try {
//       availableBiometric = await auth.getAvailableBiometrics();
//     } on PlatformException catch (e) {
//       print(e);
//     }

//     setState(() {
//       _availableBiometric = availableBiometric;
//     });
//   }

//   @override
//   void initState() {
//     _checkBiometric();
//     _getAvailableBiometric();
//     checkUsername();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Container(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 LogoImage(),
//                 // LoginTextField(),
//                 Container(
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                       TextFieldInput(
//                         controller: email,
//                         text: "email",
//                         iconName: Icons.mail,
//                         ltext: "Email",
//                       ),
//                       Center(
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(
//                               SizeConfig.screenWidth! / 20.55,
//                               SizeConfig.screenHeight! / 68.3,
//                               SizeConfig.screenWidth! / 20.55,
//                               SizeConfig.screenHeight! / 34.15),
//                           child: TextField(
//                             obscureText: passwordObscure,
//                             style: TextStyle(color: textColor),
//                             cursorColor: textColor,
//                             controller: password,
//                             decoration: InputDecoration(
//                                 prefixIcon: Icon(Icons.vpn_key),
//                                 suffixIcon: IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       passwordObscure = !passwordObscure;
//                                     });
//                                   },
//                                   icon: Icon(passwordObscure
//                                       ? Icons.visibility_off
//                                       : Icons.visibility),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(20.0)),
//                                   borderSide: BorderSide(
//                                       width: SizeConfig.screenWidth! / 205.5,
//                                       color: textColor),

//                                   /// 2
//                                 ),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10.0)),
//                                   borderSide:
//                                       BorderSide(width: 1, color: texthint),
//                                 ),
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(20.0),
//                                 ),
//                                 hintText: "password",
//                                 hintStyle:
//                                     TextStyle(color: texthint.withOpacity(0.3)),
//                                 labelText: "Password",
//                                 labelStyle: TextStyle(
//                                     color: texthint.withOpacity(0.6))),
//                           ),
//                         ),
//                       ),
//                     ])),
//                 _showFingerScanButton
//                     ? ElevatedButton(
//                         onPressed: _authenticate,
//                         child: const Icon(
//                           Icons.fingerprint_outlined,
//                           color: Colors.black,
//                         ),
//                       )
//                     : const SizedBox(),

//                 LoginButonColor(
//                   email: email,
//                   password: password,
//                 ),
//                 TextSignUp()
//               ],
//             ),
//           ),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/login_page/presentation/screen/widgets/login_button.dart';
import 'package:food_assignment/features/login_page/presentation/screen/widgets/text_field_widget/text_field_input.dart';
import 'package:food_assignment/features/shared/widgets/overlay_notification.dart';
import '../../../home_page/presentation/screen/components/colors.dart';
import '../../../shared/constants/size_config.dart';
import '../../../shared/domain/providers/shared_preferences_storage_service_provider.dart';
import '../providers/auth_providers.dart';
import 'widgets/logo.dart';
import 'widgets/text_signup.dart';
import 'package:local_auth/local_auth.dart';

class LoginPageView extends ConsumerStatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _LoginPageViewState();
}

class _LoginPageViewState extends ConsumerState<LoginPageView> {
  bool passwordObscure = true;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final auth = LocalAuthentication();
  String authorized = " not authorized";
  bool _canCheckBiometric = false;

  bool _showFingerScanButton = false;
  late List<BiometricType> _availableBiometric;

  Future<void> _authenticate() async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
        localizedReason: "Scan your finger to authenticate",
      );
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {
      authorized =
          authenticated ? "Authorized success" : "Failed to authenticate";
      print(authorized);
      if (authenticated) {
        _submit();
      } else {
        showTopOverlayNotificationError(title: "Not authenticated");
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(const SnackBar(content: Text("Not authenticated")));
      }
    });
  }

  void _submit() async {
    Object? usernameLocal = await ref.read(storageServiceProvider).get('email');
    Object? passwordLocal =
        await ref.read(storageServiceProvider).get('password');

    print("usernameLocal:::${usernameLocal}");
    print("passwordLocal:::${passwordLocal}");

    ref
        .read(authStateNotifierProvider.notifier)
        .loginUser(usernameLocal.toString(), passwordLocal.toString());
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future checkUsername() async {
    _showFingerScanButton = await ref.read(storageServiceProvider).has('email');
  }

  Future _getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {
      _availableBiometric = availableBiometric;
    });
  }

  @override
  void initState() {
    _checkBiometric();
    _getAvailableBiometric();
    checkUsername();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LogoImage(),
              // LoginTextField(),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFieldInput(
                      controller: email,
                      text: "email",
                      iconName: Icons.mail,
                      ltext: "Email",
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          SizeConfig.screenWidth! / 20.55,
                          SizeConfig.screenHeight! / 68.3,
                          SizeConfig.screenWidth! / 20.55,
                          SizeConfig.screenHeight! / 34.15,
                        ),
                        child: TextField(
                          obscureText: passwordObscure,
                          style: TextStyle(color: textColor),
                          cursorColor: textColor,
                          controller: password,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.vpn_key),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  passwordObscure = !passwordObscure;
                                });
                              },
                              icon: Icon(
                                passwordObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(
                                width: SizeConfig.screenWidth! / 205.5,
                                color: textColor,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(width: 1, color: texthint),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            hintText: "password",
                            hintStyle:
                                TextStyle(color: texthint.withOpacity(0.3)),
                            labelText: "Password",
                            labelStyle:
                                TextStyle(color: texthint.withOpacity(0.6)),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: SizeConfig.screenWidth! / 20.55,
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Handle forgot password functionality here
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _showFingerScanButton
                  ? ElevatedButton(
                      onPressed: _authenticate,
                      child: const Icon(
                        Icons.fingerprint_outlined,
                        color: Colors.black,
                      ),
                    )
                  : const SizedBox(),
              LoginButonColor(
                email: email,
                password: password,
              ),
              TextSignUp(),
            ],
          ),
        ),
      ),
    );
  }
}
