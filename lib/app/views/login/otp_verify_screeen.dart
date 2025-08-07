import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/controllers/login/otp_verify_controller.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';

class OnClocOtpVerifyScreen extends StatefulWidget {
  const OnClocOtpVerifyScreen({super.key});

  @override
  OnClocOtpVerifyScreenState createState() => OnClocOtpVerifyScreenState();
}

class OnClocOtpVerifyScreenState extends State<OnClocOtpVerifyScreen> {
  final OnClocOtpVerifyController controller = Get.put(OnClocOtpVerifyController());
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocOtpVerifyController>(
      init: controller,
      tag: 'on_cloc_otp_verify',
      builder: (_) => Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('OTP Verification'),
        ),
        body: Center(
          child: Text('OTP Verification Screen'),
        ),
      ),
    );
  }
}