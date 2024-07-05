import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../services/user_cache_service/domain/providers/current_user_provider.dart';
import '../../../../shared/constants/constants.dart';
import '../../../../shared/constants/size_config.dart';
import '../../../../shared/domain/models/user/profile_info_model.dart';
import '../../../../shared/widgets/custom_surfix_icon.dart';
import '../../../../shared/widgets/form_error.dart';
import '../../../../shared/widgets/overlay_notification.dart';
import '../../providers/profile_state_provider.dart';
// import '../../../authentication/presentation/providers/state/auth_state.dart';
// import '../providers/profile_state_provider.dart';

class CompleteProfileForm extends ConsumerStatefulWidget {
  const CompleteProfileForm({super.key});

  @override
  ConsumerState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends ConsumerState<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? name;
  String? phoneNumber;
  String? email;

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: state.when(initial: () {
            return const SizedBox();
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }, failure: (value, response) {
            name = response.data?.name;
            phoneNumber = response.data?.mobile_no.toString();
            email = response.data?.email;
            return _buildBody(response);
          }, success: (value) {
            print("VALUE:::${value.toJson()}");
            name = value.data?.name;
            phoneNumber = value.data?.mobile_no.toString();
            email = value.data?.email;
            return _buildBody(value);
          }),
        ),
      ),
    );
  }

  Widget _buildBody(ProfileInfoResponse response) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        SizeConfig.screenWidth! / 20.55,
        SizeConfig.screenHeight! / 85.375,
        SizeConfig.screenWidth! / 20.55,
        SizeConfig.screenHeight! / 85.375,
      ),
      child: Column(
        children: [
          TextFormField(
            readOnly: true,
            initialValue: email,
            onSaved: (newValue) => email = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kNamelNullError);
              }
              email = value;
              return;
            },
            decoration: const InputDecoration(
              labelText: "First Name",
              hintText: "Enter your first name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: name,
            onSaved: (newValue) => name = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kNamelNullError);
              }
              name = value;
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kNamelNullError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Full Name",
              hintText: "Enter your Full name",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: phoneNumber,
            keyboardType: TextInputType.phone,
            onSaved: (newValue) => phoneNumber = newValue,
            onChanged: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPhoneNumberNullError);
              } else if (numberValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidNumberError);
              }
              if (value.toString().length == 10) {
                removeError(error: kInvalidNumberError);
              }
              phoneNumber = value;
              return;
            },
            validator: (value) {
              if (value!.isEmpty) {
                addError(error: kPhoneNumberNullError);
                return "";
              } else if (!numberValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidNumberError);
                return "";
              } else if (value.toString().length != 10) {
                addError(error: kInvalidNumberError);
                return "";
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Phone Number",
              hintText: "Enter your phone number",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              prefixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
            ),
          ),
          const SizedBox(height: 20),
          FormError(errors: errors),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Navigator.pushNamed(context, OtpScreen.routeName);

                //check old and new data

                if (response.data?.name == name &&
                    response.data?.mobile_no.toString() == phoneNumber) {
                  showTopOverlayNotificationError(title: "No changes made");
                  return;
                }

                Map<String, dynamic> requestData = {
                  "firstname": name,
                  "mobile_no": phoneNumber,
                };

                print("REQUEST DATA::${requestData}");

                final currentUser =
                    ref.watch(currentUserProvider).asData?.value;

                if (currentUser == null) return;

                ref
                    .read(editProfileStateNotifierProvider.notifier)
                    .updateUserProfile(
                        currentUser.data!.id.toString(), requestData)
                    .whenComplete(() {
                  showTopOverlayNotification(title: "User profile updated successfully");
                  ref.read(profileNotifierProvider.notifier).getUserProfile();
                  Navigator.pop(context);
                });
              }
            },
            child: const Text("Continue"),
          ),
        ],
      ),
    );
  }
}
