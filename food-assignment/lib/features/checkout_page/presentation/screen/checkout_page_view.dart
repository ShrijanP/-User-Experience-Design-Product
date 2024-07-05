import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/checkout_page/presentation/screen/components/page_name.dart';
import 'package:food_assignment/features/checkout_page/presentation/screen/widgets/address.dart';
import 'package:food_assignment/features/checkout_page/presentation/screen/widgets/payment.dart';
import 'package:food_assignment/features/shared/widgets/overlay_notification.dart';
// import 'package:food_assignment/features/checkout_page/widgets/address.dart';
// import 'package:food_assignment/features/checkout_page/widgets/payment.dart';
// import 'package:food_assignment/features/home_page/components/colors.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';
import 'package:food_assignment/features/success_page/success_page_view.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../../../cart_page/presentation/providers/cart_state_providers.dart';
import '../../../cart_page/presentation/providers/state/cart_state.dart';
import '../../../home_page/presentation/screen/components/colors.dart';
import '../../../order/presentation/providers/my_order_state_providers.dart';
import '../../../shared/constants/size_config.dart';
import 'components/checkout_textfield.dart';

class CheckoutPageView extends ConsumerStatefulWidget {
  final String cartId;
  final String amount;
  const CheckoutPageView({Key? key, required this.cartId, required this.amount})
      : super(key: key);

  @override
  ConsumerState createState() => _CheckoutPageViewState();
}

class _CheckoutPageViewState extends ConsumerState<CheckoutPageView> {
  int currentStep = 0;
  bool isCompleted = false;

  TextEditingController checkoutController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  bool cashBool = false;
  bool khaltiBool = false;

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text(
            "Address",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageName(text_name: "Full Name"),
              CheckoutTextField(
                controller: fullNameController,
                enter_text: "Enter your full name",
                size_width: 1.18,
              ),
              PageName(text_name: "Phone"),
              CheckoutTextField(
                controller: numberController,
                enter_text: "Enter your phone number",
                size_width: 1.18,
              ),
              PageName(text_name: "Address"),
              CheckoutTextField(
                controller: checkoutController,
                enter_text: "Type your home address",
                size_width: 1.18,
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text(
            "Complete",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          content: const Payment(),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    final remoteState = ref.watch(checkOutStateNotifierProvider);
    ref.listen(
      checkOutStateNotifierProvider.select((value) => value),
      ((previous, next) {
        if (next is Failure) {
          showTopOverlayNotificationError(
              title: next.exception.message.toString());
        } else if (next is Success) {
          Navigator.pop(context);
          ref.read(myCartStateNotifierProvider.notifier).fetchMyCart();
          showTopOverlayNotification(
              title: "Order has been successfully placed");
        }
      }),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            "Checkout",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          elevation: 0,
        ),
        body: isCompleted
            ? const CheckCart()
            : Theme(
                data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(primary: buttonColor)),
                child: Stepper(
                  type: StepperType.vertical,
                  steps: getSteps(),
                  currentStep: currentStep,
                  onStepContinue: () {
                    final isLastStep = currentStep == getSteps().length - 1;
                    if (isLastStep) {
                      if (cashBool) {
                        ref
                            .read(checkOutStateNotifierProvider.notifier)
                            .checkOUt(checkoutController.text,
                                widget.cartId.toString())
                            .then((_) {
                          ref
                              .read(myOrderStateNotifierProvider.notifier)
                              .fetchOrder();
                        });
                        setState(() => isCompleted = true);
                      } else if (khaltiBool) {
                        KhaltiScope.of(context).pay(
                          config: PaymentConfig(
                            amount: int.parse(widget.amount) * 100,
                            productIdentity: widget.cartId.toString(),
                            productName: "Product",
                          ),
                          preferences: [
                            PaymentPreference.khalti,
                          ],
                          onSuccess: (su) async {
                            setState(() => isCompleted = true);

                            ref
                                .read(checkOutStateNotifierProvider.notifier)
                                .checkOUt(checkoutController.text,
                                    widget.cartId.toString())
                                .then((_) {
                              ref
                                  .read(myOrderStateNotifierProvider.notifier)
                                  .fetchOrder();
                            });
                          },
                          onFailure: (fa) {
                            const failedsnackBar = SnackBar(
                              content: Text('Payment Failed'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(failedsnackBar);
                          },
                          onCancel: () {
                            const cancelsnackBar = SnackBar(
                              content: Text('Payment Cancelled'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(cancelsnackBar);
                          },
                        );
                      } else {
                        showTopOverlayNotificationError(
                            title: "Please select Payment method");
                      }
                      print("Completed");
                    } else {
                      if (checkoutController.text.isNotEmpty &&
                          numberController.text.isNotEmpty &&
                          fullNameController.text.isNotEmpty) {
                        setState(() => currentStep += 1);
                      } else {
                        showTopOverlayNotificationError(
                            title: "Please Enter all Fields");
                      }
                    }
                  },
                  onStepTapped: (step) => setState(() => currentStep = step),
                  onStepCancel: currentStep == 0
                      ? null
                      : () {
                          setState(() => currentStep -= 1);
                        },
                  controlsBuilder:
                      (BuildContext context, ControlsDetails controls) {
                    final isLastStep = currentStep == getSteps().length - 1;
                    return Container(
                      margin:
                          EdgeInsets.only(top: SizeConfig.screenHeight! / 68.3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          isLastStep
                              ? Column(
                                  children: [
                                    const Text(
                                      "Proceed to Payment",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: cashBool,
                                            onChanged: (value) {
                                              setState(() {
                                                khaltiBool = false;
                                                cashBool = value!;
                                              });
                                            }),
                                        const Text(
                                          "Cash on Delivery",
                                          style: TextStyle(fontSize: 17),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: khaltiBool,
                                            onChanged: (value) {
                                              setState(() {
                                                cashBool = false;
                                                khaltiBool = value!;
                                              });
                                            }),
                                        const Text("Khalti",
                                            style: TextStyle(fontSize: 17))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                )
                              : Container(),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: controls.onStepContinue,
                                  child: Container(
                                    height: SizeConfig.screenHeight! / 13.66,
                                    decoration: BoxDecoration(
                                        color: buttonColor,
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: Center(
                                      child: Text(
                                        isLastStep ? "Confirm" : "Next",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: SizeConfig.screenHeight! /
                                                37.95,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.screenWidth! / 34.25,
                              ),
                              if (currentStep != 0)
                                Expanded(
                                  child: InkWell(
                                    onTap: controls.onStepCancel,
                                    child: Container(
                                      height: SizeConfig.screenHeight! / 13.66,
                                      decoration: BoxDecoration(
                                          color: buttonColor,
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      child: Center(
                                        child: Text(
                                          "Back",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                                  SizeConfig.screenHeight! /
                                                      37.95,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )));
  }
}
