import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/device/device_verification_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:on_cloc_mobile/widgets/common_button.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocDeviceVerificationScreen extends StatefulWidget {
  const OnClocDeviceVerificationScreen({super.key});

  @override
  State<OnClocDeviceVerificationScreen> createState() =>
      OnClocDeviceVerificationScreenState();
}

class OnClocDeviceVerificationScreenState extends State<OnClocDeviceVerificationScreen> {
  final OnClocDeviceVerificationController controller = Get.put(OnClocDeviceVerificationController());
  late ThemeData theme;

  bool isLoading = false;

  @override
  void initState() {
    init();
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  void init() async {
    await controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocDeviceVerificationController>(
      init: controller,
      tag: 'on_cloc_device_verification',
      builder:
          (controller) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: onClocCommonAppBarWidget(
              context,
              leadingWidth: 0,
              leadingWidget: const Wrap(),
              isback: false,
              isTitleCenter: false,
              titleText: onClocLocale.lblDeviceVerificationTitle,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Obx(() {
                      if (controller.deviceStatus.value ==
                          DeviceVerificationStatus.verifying) {
                        return Lottie.asset(onClocVerificationAnimation);
                      } else if (controller.deviceStatus.value ==
                          DeviceVerificationStatus.pending) {
                        return Column(
                          children: [
                            100.height,
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      mobileDeviceLock,
                                      width: 200,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (controller.deviceStatus.value ==
                          DeviceVerificationStatus.alreadyRegistered) {
                        return Lottie.asset(
                          onClocFailedAnimation,
                          repeat: false,
                        );
                      } else if (controller.deviceStatus.value ==
                          DeviceVerificationStatus.notRegistered) {
                        return Column(
                          children: [
                            100.height,
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      mobileDeviceLock,
                                      width: 200,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else if (controller.deviceStatus.value ==
                          DeviceVerificationStatus.verified) {
                        return Lottie.asset(
                          onClocSuccessAnimation,
                          repeat: false,
                        );
                      } else {
                        return Lottie.asset(
                          onClocFailedAnimation,
                          repeat: false,
                        );
                      }
                    }),
                    10.height,
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: Obx(() {
                            if (controller.deviceStatus.value ==
                                DeviceVerificationStatus.verifying) {
                              return Column(
                                children: [
                                  Text(
                                    onClocLocale.lblVerifyingDevice,
                                    style: primaryTextStyle(
                                      color:
                                          Get.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    onClocLocale.lblHoldOn,
                                    style: primaryTextStyle(
                                      color:
                                          Get.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            } else if (controller.deviceStatus.value ==
                                DeviceVerificationStatus.pending) {
                              return Column(
                                children: [
                                  Text(
                                    onClocLocale.lblVerificationPending,
                                    style: primaryTextStyle(
                                      color:
                                          Get.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    onClocLocale
                                        .lblYourDeviceVerificationIsPending,
                                    style: primaryTextStyle(
                                      color:
                                          Get.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            } else if (controller.deviceStatus.value ==
                                DeviceVerificationStatus.alreadyRegistered) {
                              return Column(
                                children: [
                                  Text(
                                    onClocLocale.lblDeviceVerificationFailed,
                                    style: primaryTextStyle(
                                      color:
                                          Get.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    onClocLocale
                                        .lblThisDeviceIsAlreadyRegisteredWithOtherAccountPleaseContactAdministrator,
                                    style: primaryTextStyle(
                                      color:
                                          Get.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            } else if (controller.deviceStatus.value ==
                                DeviceVerificationStatus.notRegistered) {
                              return Column(
                                children: [
                                  Text(
                                    onClocLocale.lblNewDevice,
                                    style: primaryTextStyle(
                                      color:
                                          Get.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    onClocLocale
                                        .lblThisDeviceIsNotRegisteredClickOnRegisterToAddItToYourAccount,
                                    style: primaryTextStyle(
                                      color:
                                          Get.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            } else if (controller.deviceStatus.value ==
                                DeviceVerificationStatus.verified) {
                              return Column(
                                children: [
                                  Text(
                                    onClocLocale.lblVerificationCompleted,
                                    style: primaryTextStyle(
                                      color:
                                          Get.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    onClocLocale
                                        .lblYourDeviceVerificationIsSuccessfullyCompleted,
                                    style: primaryTextStyle(
                                      color:
                                          Get.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  Text(
                                    onClocLocale.lblDeviceVerificationFailed,
                                    style: primaryTextStyle(
                                      color:
                                          Get.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    onClocLocale
                                        .lblVerificationFailedPleaseTryAgain,
                                    style: primaryTextStyle(
                                      color:
                                          Get.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    15.height,
                    Obx(() {
                        if (controller.deviceStatus.value ==
                            DeviceVerificationStatus.verified) {
                          return OnClocCommonButton(
                            text: onClocLocale.lblOk,
                            bgColor: servpalSecondaryColor,
                            textColor: Get.isDarkMode
                                ? servpalTextColorDark
                                : servpalTextColorLight,
                            onPressed: () async {
                              if (getBoolAsync(isDeviceVerifiedPref)) {
                                await onClocSharedHelper.refreshAppSettings();
                                toast(onClocLocale.lblWelcomeBack);
                                if (!mounted) return;
                                Get.toNamed(
                                  OnClocRoutes.onClocNavigationScreen,
                                );
                              }
                            },
                          );
                        } else if (controller.deviceStatus.value ==
                            DeviceVerificationStatus.notRegistered) {
                          return OnClocCommonButton(
                            text: onClocLocale.lblRegisterDevice,
                            bgColor: servpalSecondaryColor,
                            textColor: Get.isDarkMode
                                ? servpalTextColorDark
                                : servpalTextColorLight,
                            onPressed: () async {
                              await controller.registerDevice();
                              if (getBoolAsync(isDeviceVerifiedPref)) {
                                onClocSharedHelper.refreshAppSettings();
                                if (!mounted) return;
                                Get.toNamed(
                                  OnClocRoutes.onClocNavigationScreen,
                                );
                              }
                            },
                          );
                        } else if (controller.deviceStatus.value ==
                                DeviceVerificationStatus.alreadyRegistered ||
                            controller.deviceStatus.value ==
                                DeviceVerificationStatus.failed) {
                          return OnClocCommonButton(
                            text: onClocLocale.lblLogOut,
                            bgColor: servpalSecondaryColor,
                            textColor: Get.isDarkMode
                                ? servpalTextColorDark
                                : servpalTextColorLight,
                            onPressed: () {
                              onClocSharedHelper.logout();
                            },
                          );
                        }

                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
