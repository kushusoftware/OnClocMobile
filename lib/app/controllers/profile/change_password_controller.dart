import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/main.dart';

class OnClocChangePasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();

  final formKey = GlobalKey<FormState>();

  RxBool isPasswordEnabled = false.obs;
  RxBool isConPasswordEnabled = false.obs;

  RxBool isIconTrue = true.obs;
  RxBool isConIconTrue = true.obs;

  String validatePassword(String text) {
    if (text.isEmpty) {
      isPasswordEnabled.value = false;
      return onClocLocale.lblPasswordIsRequired;
    }
    if (text.length < 8) {
      isPasswordEnabled.value = false;
      return onClocLocale.lblPasswordMustBeAtLeast8CharactersLong;
    }

    isPasswordEnabled.value = true;
    return '';
  }

  String validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      isConPasswordEnabled.value = false;
      return onClocLocale.lblConfirmPasswordIsRequired;
    }
    if (password != confirmPassword) {
      isConPasswordEnabled.value = false;
      return onClocLocale.lblPasswordsDoNotMatch;
    }

    isConPasswordEnabled.value = true;
    return '';
  }

  bool isFormValid() {
    return isPasswordEnabled.value && isConPasswordEnabled.value && validateConfirmPassword(
        passwordController.text,
        confirmPasswordController.text)
        .isEmpty;
  }

  @override
  void onInit() {

    super.onInit();
    passwordController.text = '12345678';
    confirmPasswordController.text = '12345678';
    isPasswordEnabled.value =true;
    isConPasswordEnabled.value =true;
  }
}