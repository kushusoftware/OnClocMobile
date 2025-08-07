import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/login/forgot_password_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:on_cloc_mobile/widgets/common_button.dart';
import 'package:on_cloc_mobile/widgets/form_fields.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocForgotPasswordScreen extends StatefulWidget {
  const OnClocForgotPasswordScreen({super.key});

  @override
  OnClocForgotPasswordScreenState createState() => OnClocForgotPasswordScreenState();
}

class OnClocForgotPasswordScreenState extends State<OnClocForgotPasswordScreen> {
  final OnClocForgotPasswordController controller = Get.put(OnClocForgotPasswordController());
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme =
        Get.isDarkMode
            ? OnClocTheme.darkTheme
            : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocForgotPasswordController>(
      init: controller,
      tag: 'on_cloc_forgot_password',
      builder:
          (_) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: onClocCommonAppBarWidget(context,
            titleText: onClocLocale.lblForgotPassword),
            bottomNavigationBar: Obx(
              () => Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  top: 15,
                  right: 20,
                  bottom:
                      GetPlatform.isIOS
                          ? MediaQuery.of(context).padding.bottom
                          : 20.0,
                ),
                child: OnClocCommonButton(
                  bgColor:
                      (controller.isEmailEnabled.value)
                          ? servpalPrimaryColorLight
                          : onClocGreyColor.withValues(alpha: 0.20),
                  textColor:
                      (controller.isEmailEnabled.value)
                          ? Colors.white
                          : Get.isDarkMode
                          ? Colors.white
                          : servpalTextColorLight,
                  onPressed: () async {
                    if ((controller.isEmailEnabled.value)) {
                      Get.toNamed(OnClocRoutes.onClocOtpVerifyScreen);
                    }
                  },
                  text: onClocLocale.lblContinueText,
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    8.height,
                    Text(
                      onClocLocale.lblSelectContactDetailsToResetPassword,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                        color: onClocGreyColor,
                      ),
                    ),
                    30.height,
                    Center(
                      child: SvgPicture.asset(
                        Get.isDarkMode
                            ? onClocForgotPasswordBgDark
                            : onClocForgotPasswordBgLight,
                        width: 260,
                        height: 257,
                      ),
                    ),
                    30.height,
                    OutlineBorderTextFormField(
                      labelText: onClocLocale.lblEmailAddress,
                      myFocusNode: controller.f1,
                      tempTextEditingController: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      autofocus: false,
                      checkOfErrorOnFocusChange: true,
                      inputFormatters: [
                        // Limit the length to 20 characters
                        LengthLimitingTextInputFormatter(120),
                        // Allow only specified characters
                        FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9@!#$%&*_-]+'),
                        ),
                      ],
                      validation: (textToValidate) {
                        return controller.validateEmail(textToValidate);
                      },
                      theme: theme,
                    ),
                    20.height,
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
