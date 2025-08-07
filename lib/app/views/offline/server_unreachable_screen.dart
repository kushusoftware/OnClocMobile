import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocServerUnreachableScreen extends StatefulWidget {
  const OnClocServerUnreachableScreen({super.key});

  @override
  State<OnClocServerUnreachableScreen> createState() => OnClocServerUnreachableScreenState();
}

class OnClocServerUnreachableScreenState extends State<OnClocServerUnreachableScreen> {
  bool isLoading = false;

  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: onClocCommonAppBarWidget(
        context,
        leadingWidth: 0,
        leadingWidget: const Wrap(),
        isback: false,
        titleText: onClocLocale.lblServerUnreachable,
      ),
      body: SafeArea(
        child: Center(
          child:
              isLoading
                  ? const CircularProgressIndicator()
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        onClocOfflineAnimation,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      16.height,
                      AppButton(
                        shapeBorder: buildButtonCorner(),
                        color: servpalPrimaryColor,
                        textColor: Colors.white,
                        text: onClocLocale.lblRetry,
                        onTap: () => checkStatus(),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }

  void checkStatus() async {
    setState(() {
      isLoading = true;
    });
    try {
      setState(() {});
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      if (getBoolAsync(isLoggedInPref)) {
        await onClocSharedHelper.refreshAppSettings();
        toast(onClocLocale.lblBackOnline);
        if (getBoolAsync(isDeviceVerifiedPref)) {
          if (!mounted) return;
          Get.toNamed(OnClocRoutes.onClocNavigationScreen);
        } else {
          if (!mounted) return;
          Get.toNamed(OnClocRoutes.onClocDeviceVerificationScreen);
        }
      } else {
        Get.toNamed(OnClocRoutes.onClocLoginScreen);
        return;
      }
    } catch (e) {
      toast(onClocLocale.lblServerUnreachable);
      setState(() {
        isLoading = false;
      });
    }
  }
}
