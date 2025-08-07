import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/login/login_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:on_cloc_mobile/widgets/common_button.dart';
import 'package:on_cloc_mobile/widgets/form_fields.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';

class OnClocLoginScreen extends StatefulWidget {
  const OnClocLoginScreen({super.key});

  @override
  OnClocLoginScreenState createState() => OnClocLoginScreenState();
}

class OnClocLoginScreenState extends State<OnClocLoginScreen> {
  final OnClocLoginController controller = Get.put(OnClocLoginController());
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
    return GetBuilder<OnClocLoginController>(
      init: controller,
      tag: 'on_cloc_login',
      builder:
          (controller) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(
                bottom:
                    GetPlatform.isIOS
                        ? MediaQuery.of(context).padding.bottom
                        : 20.0,
              ),
              child: InkWell(
                onTap: () {
                  controller.goToEnrol();
                },
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    text: appPoweredBy,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                    children: [
                      TextSpan(
                        text: kushuSoftware,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                          color: servpalPrimaryColorLight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.height,
                      SvgPicture.asset(onClocLogo, width: 100, height: 67),
                      25.height,
                      Text(
                        onClocLocale.lblWelcomeBack,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '$appName, $clientName',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: servpalPrimaryColorLight,
                        ),
                      ),
                      8.height,
                      Text(
                        onClocLocale.lblLoginToContinue,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                          color: onClocGreyColor,
                        ),
                      ),
                      30.height,
                      OutlineBorderTextFormField(
                          labelText: onClocLocale.lblEmailAddress,
                          isIconTrue: controller.isIconTrue.value,
                          myFocusNode: controller.f1,
                          tempTextEditingController: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofocus: false,
                          checkOfErrorOnFocusChange: true,
                          inputFormatters: const [],
                          validation: (textToValidate) {
                            return controller.validateEmailText(textToValidate);
                          },
                          theme: theme,
                      ),
                      20.height,
                      Obx(
                        () => OutlineBorderTextFormField(
                          labelText: onClocLocale.lblPassword,
                          isIconTrue: controller.isIconTrue.value,
                          obscureText: controller.isIconTrue.value,
                          suffixIcon: Theme(
                            data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child: IconButton(
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                controller.isIconTrue.value =
                                    !controller.isIconTrue.value;
                              },
                              icon: SvgPicture.asset(
                                (controller.isIconTrue.value)
                                    ? onClocEyeOpenIcon
                                    : onClocEyeClosedIcon,
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                  Get.isDarkMode
                                      ? Colors.white
                                      : onClocPrimaryIconColorLight,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          prefixIconColor:
                              Get.isDarkMode
                                  ? Colors.white
                                  : theme.primaryColor,
                          myFocusNode: controller.f2,
                          tempTextEditingController: controller.passwordController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autofocus: false,
                          checkOfErrorOnFocusChange: true,
                          inputFormatters: [
                            // Limit the length to 20 characters
                            LengthLimitingTextInputFormatter(20),
                            // Allow only specified characters
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9@!#$%&*_-]+'),
                            ),
                          ],
                          validation: (textToValidate) {
                            return controller.validatePasswordText(textToValidate);
                          },
                          theme: theme,
                        ),
                      ),
                      10.height,
                      InkWell(
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Get.toNamed(OnClocRoutes.onClocForgotPasswordScreen);
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            onClocLocale.lblForgotPassword,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w300,
                              color: theme.primaryColor,
                            ),
                          ),
                        ),
                      ),
                      20.height,
                      Obx(
                        () => OnClocCommonButton(
                          bgColor:
                              (controller.isEmailEnabled.value &&
                                      controller.isPasswordEnabled.value)
                                  ? theme.primaryColor
                                  : onClocGreyColor.withValues(alpha: 0.20),
                          textColor:
                              (controller.isEmailEnabled.value &&
                                      controller.isPasswordEnabled.value)
                                  ? Colors.white
                                  : Get.isDarkMode
                                  ? Colors.white
                                  : servpalTextColorLight,
                          onPressed: () async {
                            await controller.validateRemoteLogin();
                            if ((controller.isEmailEnabled.value &&
                                controller.isPasswordEnabled.value)) {
                              Get.offNamedUntil(
                                OnClocRoutes.onClocNavigationScreen,
                                (route) => route.isFirst,
                              );
                            }
                          },
                          text: onClocLocale.lblLogIn,
                        ),
                      ),
                      20.height,
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
