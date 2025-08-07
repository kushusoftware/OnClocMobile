import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/controllers/login/two_factor_authenication_controller.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';

class OnClocTwoFactorAuthenticationScreen extends StatefulWidget {
  const OnClocTwoFactorAuthenticationScreen({super.key});

  @override
  State<OnClocTwoFactorAuthenticationScreen> createState() => OnClocTwoFactorAuthenticationScreenState();
}

class OnClocTwoFactorAuthenticationScreenState extends State<OnClocTwoFactorAuthenticationScreen> {
  final OnClocTwoFactorAuthenticationController controller = Get.put(OnClocTwoFactorAuthenticationController());
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocTwoFactorAuthenticationController>(
      init: controller,
      tag: 'on_cloc_tfa',
      builder: (_) => Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('Two Factor Authentication'),
          backgroundColor: theme.primaryColor,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter the code sent to your email',
                ),
                SizedBox(height: 20),
                TextField(
                  controller: controller.codeController,
                  decoration: InputDecoration(
                    labelText: 'Code',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    controller.verifyCode();
                  },
                  child: Text('Verify Code'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
