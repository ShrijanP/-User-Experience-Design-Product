import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../order/presentation/providers/my_order_state_providers.dart';
import '../../../../order/presentation/screen/my_order_screen.dart';
import '../../../../shared/constants/size_config.dart';
import '../components/colors.dart';

class UserNameText extends ConsumerStatefulWidget {
  const UserNameText({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _UserNameTextState();
}

class _UserNameTextState extends ConsumerState<UserNameText> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(myOrderStateNotifierProvider);
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.screenWidth! / 14.17,
          SizeConfig.screenHeight! / 23.55,
          SizeConfig.screenWidth! / 11.74,
          SizeConfig.screenHeight! / 68.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.screenHeight! / 85.38,
                        bottom: SizeConfig.screenHeight! / 113.84),
                    child: Text(
                      "Namaste ",
                      style: TextStyle(
                          fontSize: SizeConfig.screenHeight! / 29.7,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: SizeConfig.screenHeight! / 85.38),
                    child: Container(
                      height: SizeConfig.screenHeight! / 22.77,
                      width: SizeConfig.screenWidth! / 13.7,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/main/waving-hand.png"))),
                    ),
                  )
                ],
              ),
              Text(
                "Peak Performers",
                style: TextStyle(
                    fontSize: SizeConfig.screenHeight! / 40.18,
                    color: Colors.black54),
              )
            ],
          ),
          Stack(
            children: [
              Container(
                height: SizeConfig.screenHeight! / 17.07,
                width: SizeConfig.screenWidth! / 5.13,
                decoration: BoxDecoration(
                    color: lightColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30.0)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyOrderScreen()));
                },
                child: Container(
                    height: SizeConfig.screenHeight! / 17.07,
                    width: SizeConfig.screenWidth! / 10.28,
                    decoration: BoxDecoration(
                        color: buttonColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: const Icon(
                      Icons.add_shopping_cart_outlined,
                      color: Colors.white,
                    )),
              ),
              Positioned(
                right: SizeConfig.screenWidth! / 20.55,
                bottom: SizeConfig.screenHeight! / 62.01,
                child: state.when(
                    initial: () => const Center(
                          child: Text("No Order Found"),
                        ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    failure: (failure, data) =>
                        data.data == null || data.data!.isEmpty
                            ? const Text(
                                "0",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                data.data!.length.toString(),
                                style: const TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                    success: (data) => data.data == null || data.data!.isEmpty
                        ? const Text(
                            "0",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(
                            data.data!.length.toString(),
                            style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
