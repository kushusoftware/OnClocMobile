import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnClocOtpVerifyController extends GetxController {
  final otpController = TextEditingController();
  final otpFocusNode = FocusNode();
  final otpFormKey = GlobalKey<FormState>();

  void verifyOtp() {
    if (otpFormKey.currentState!.validate()) {
      // Call API to verify OTP
    }
  }
}