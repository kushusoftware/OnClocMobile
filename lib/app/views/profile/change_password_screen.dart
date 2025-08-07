import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/profile/change_password_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';
import 'package:on_cloc_mobile/widgets/common_button.dart';
import 'package:on_cloc_mobile/widgets/form_fields.dart';

class OnClocChangePasswordScreen extends StatefulWidget {
  const OnClocChangePasswordScreen({super.key});

  @override
  OnClocChangePasswordScreenState createState() => OnClocChangePasswordScreenState();
}

class OnClocChangePasswordScreenState extends State<OnClocChangePasswordScreen> {
  final OnClocChangePasswordController controller = Get.put(OnClocChangePasswordController());
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
    return GetBuilder<OnClocChangePasswordController>(
      init: controller,
      tag: 'on_cloc_change_assword',
      builder:
          (_) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: onClocCommonAppBarWidget(
              context,
              titleText: onClocLocale.lblChangePasswordScreenTitle,
            ),
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
                      (controller.isFormValid())
                          ? servpalPrimaryColor
                          : onClocGreyColor.withValues(alpha: 0.20),
                  textColor:
                      (controller.isFormValid())
                          ? Colors.white
                          : Get.isDarkMode
                          ? servpalTextColorDark
                          : servpalTextColorLight,
                  onPressed: () async {
                    if ((controller.isFormValid() &&
                        controller
                            .validateConfirmPassword(
                              controller.passwordController.text,
                              controller.confirmPasswordController.text,
                            )
                            .isEmpty)) {
                      Get.offNamedUntil(
                        OnClocRoutes.onClocLoginScreen,
                        (route) => route.isFirst,
                      );
                    }
                  },
                  text: onClocLocale.lblUpdate,
                ),
              ),
            ),
            body: SafeArea(child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    30.height,
                    Obx(
                      () => OutlineBorderTextFormField(
                        obscureText: controller.isIconTrue.value,
                        suffixIcon: Theme(
                          data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent),
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
                                  Get.isDarkMode ? servpalIconColorDark : servpalIconColorLight,
                                  BlendMode.srcIn),
                            ),
                          ),
                        ),
                        labelText: onClocLocale.lblPassword,
                        prefixIconColor:
                            Get.isDarkMode ? servpalIconColorDark : servpalIconColorLight,
                        myFocusNode: controller.f1,
                        tempTextEditingController:
                            controller.passwordController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        autofocus: false,
                        checkOfErrorOnFocusChange: true,
                        inputFormatters: [
                          // Limit the length to 20 characters
                          LengthLimitingTextInputFormatter(20),
                          // Allow only specified characters
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9@!#$%&*_-]+')),
                        ],
                        validation: (textToValidate) {
                          return controller.validatePassword(textToValidate);
                        },
                        theme: theme,
                      ),
                    ),
                    20.height,
                    Obx(
                      () => OutlineBorderTextFormField(
                        obscureText: controller.isConIconTrue.value,
                        suffixIcon: Theme(
                          data: ThemeData(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent),
                          child: IconButton(
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              controller.isConIconTrue.value =
                                  !controller.isConIconTrue.value;
                            },
                            icon: SvgPicture.asset(
                              (controller.isConIconTrue.value)
                                  ? onClocEyeOpenIcon
                                  : onClocEyeClosedIcon,
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                  Get.isDarkMode ?  servpalIconColorDark : servpalIconColorLight,
                                  BlendMode.srcIn),
                            ),
                          ),
                        ),
                        labelText: onClocLocale.lblConfirmPassword,
                        prefixIconColor:
                            Get.isDarkMode ? servpalIconColorDark : servpalIconColorLight,
                        myFocusNode: controller.f2,
                        tempTextEditingController:
                            controller.confirmPasswordController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        autofocus: false,
                        checkOfErrorOnFocusChange: true,
                        inputFormatters: [
                          // Limit the length to 20 characters
                          LengthLimitingTextInputFormatter(20),
                          // Allow only specified characters
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z0-9@!#$%&*_-]+')),
                        ],
                        validation: (textToValidate) {
                          return controller.validateConfirmPassword(
                              controller.passwordController.text,
                              textToValidate);
                        },
                        theme: theme,
                      ),
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
