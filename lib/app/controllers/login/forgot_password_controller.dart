import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnClocForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  FocusNode f1 = FocusNode();
  RxBool isEmailEnabled = false.obs;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      isEmailEnabled.value = false;
      return 'Please enter your email';
    }
    // Use regex for email validation
    if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      isEmailEnabled.value = false;
      return 'Please enter a valid email';
    }
    isEmailEnabled.value = true;
    return '';
  }
}