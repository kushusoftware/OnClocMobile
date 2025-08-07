import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/settings/settings_controller.dart';
import 'package:on_cloc_mobile/app/controllers/theme/theme_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocSettingsScreen extends StatefulWidget {
  const OnClocSettingsScreen({super.key});

  @override
  OnClocSettingsScreenState createState() => OnClocSettingsScreenState();
}

class OnClocSettingsScreenState extends State<OnClocSettingsScreen> {
  OnClocSettingsController controller = Get.put(OnClocSettingsController());
  final OnClocThemeController themeController = Get.put(
    OnClocThemeController(),
  );
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocSettingsController>(
      init: controller,
      tag: 'on_cloc_settings',
      builder:
          (_) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: onClocCommonAppBarWidget(
              context,
              titleText: onClocLocale.lblSettingsScreenTitle,
              actionWidget: InkWell(
                onTap: () {
                  controller.refreshAppSettings();
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: SvgPicture.asset(
                    onClocRefreshIcon,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Get.isDarkMode
                          ? servpalTextColorDark
                          : servpalTextColorLight,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    20.height,
                    onClocCommonListViewItemWidget(
                      onClocMobileIcon,
                      onClocLocale.lblDeviceStatusTitle,
                      themeController.isDarkMode,
                      theme,
                      () async {
                        Get.toNamed(OnClocRoutes.onClocDeviceStatusScreen);
                      },
                    ),
                    Divider(color: onClocGreyColor.withValues(alpha: 0.10)),
                    onClocCommonListViewItemWidget(
                      onClocLanguageIcon,
                      onClocLocale.lblLanguage,
                      themeController.isDarkMode,
                      theme,
                      () async {
                        await Get.toNamed(
                          OnClocRoutes.onClocLanguageSelectionScreen,
                        );
                      },
                    ),
                    Divider(color: onClocGreyColor.withValues(alpha: 0.10)),
                    onClocCommonListViewItemWidget(
                      onClocHolidayIcon,
                      onClocLocale.lblWeatherForecast,
                      themeController.isDarkMode,
                      theme,
                      () async {
                        await Get.toNamed(
                          OnClocRoutes.onClocWeatherForecastScreen,
                        );
                      },
                    ),
                    Divider(color: onClocGreyColor.withValues(alpha: 0.10)),
                    onClocCommonListViewItemWidget(
                      onClocRefreshIcon,
                      onClocLocale.lblRefreshAppConfiguration,
                      themeController.isDarkMode,
                      theme,
                      () async {
                        controller.refreshAppSettings();
                      },
                    ),
                    Divider(color: onClocGreyColor.withValues(alpha: 0.10)),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
