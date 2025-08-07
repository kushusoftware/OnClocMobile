import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/offline/offline_mode_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocOfflineModeScreen extends StatefulWidget {
  const OnClocOfflineModeScreen({super.key});

  @override
  State<OnClocOfflineModeScreen> createState() =>
      OnClocOfflineModeScreenState();
}

class OnClocOfflineModeScreenState extends State<OnClocOfflineModeScreen> {
  final OnClocOfflineModeController controller = Get.put(OnClocOfflineModeController());
  late ThemeData theme;

  bool isLoading = false;

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
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: onClocCommonAppBarWidget(
        context,
        leadingWidth: 0,
        leadingWidget: const Wrap(),
        isback: false,
        titleText: onClocLocale.lblOfflineMode,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                onClocOfflineAnimation,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              16.height,
              Text(
                onClocLocale.lblYouAreInOfflineMode,
                style: boldTextStyle(size: 20),
              ),
              8.height,
              Text(
                onClocLocale.lblOfflineModeLimitedOptions,
                style: secondaryTextStyle(size: 16),
              ),
              32.height,
              isLoading
                  ? const CircularProgressIndicator()
                  : AppButton(
                    text: onClocLocale.lblRefresh,
                    color: context.primaryColor,
                    textStyle: boldTextStyle(color: Colors.white),
                    onTap: () {
                      checkStatus();
                    },
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
        if (!mounted) return;
        Get.toNamed(OnClocRoutes.onClocNavigationScreen);
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
