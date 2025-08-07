import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/components/side_drawer_controller.dart';
import 'package:on_cloc_mobile/app/controllers/theme/theme_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocSideDrawerComponent extends StatefulWidget {
  const OnClocSideDrawerComponent({super.key});

  @override
  State<OnClocSideDrawerComponent> createState() =>
      OnClocSideDrawerComponentState();
}

class OnClocSideDrawerComponentState extends State<OnClocSideDrawerComponent> {
  OnClocSideDrawerController controller = Get.put(OnClocSideDrawerController());
  final OnClocThemeController themeController = Get.put(
    OnClocThemeController(),
  );

  late ThemeData theme;

  String appVersion = '';

  @override
  void initState() {
    super.initState();
    theme =
        themeController.isDarkMode
            ? OnClocTheme.darkTheme
            : OnClocTheme.lightTheme;
    init();
  }

  void init() async {
    // Initialize any necessary data or state here
    appVersion = await onClocSharedHelper.getAppVersionString();
  }

  @override
  void didChangeDependencies() {
    theme =
        themeController.isDarkMode
            ? OnClocTheme.darkTheme
            : OnClocTheme.lightTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocSideDrawerController>(
      init: controller,
      tag: 'side_drawer',
      builder:
          (controller) => Drawer(
            backgroundColor:  themeController.isDarkMode
              ? servpalBgColorDark
              : servpalBgColorLight,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopProfilePicView(),
                  10.height,
                  Center(
                    child: Text(
                      '${getStringAsync(firstNamePref)} ${getStringAsync(lastNamePref)}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color:
                            themeController.isDarkMode
                                ? servpalTextColorDark
                                : servpalTextColorLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  4.height,
                  Center(
                    child: Text(
                      getStringAsync(emailPref),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color:
                            themeController.isDarkMode
                                ? servpalTextColorDark
                                : servpalTextColorLight,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  20.height,
                  Divider(color: onClocGreyColor.withValues(alpha: 0.10)),
                  onClocCommonListViewItemWidget(
                    onClocProfileIcon,
                    onClocLocale.lblMyProfile,
                    themeController.isDarkMode,
                    theme,
                    () {
                      Get.toNamed(OnClocRoutes.onClocUserProfileScreen);
                    },
                  ),
                  Divider(color: onClocGreyColor.withValues(alpha: 0.10)),
                  onClocCommonListViewItemWidget(
                    onClocLockIcon,
                    onClocLocale.lblChangePassword,
                    themeController.isDarkMode,
                    theme,
                    () {
                      Get.toNamed(OnClocRoutes.onClocChangePasswordScreen);
                    },
                  ),
                  Divider(color: onClocGreyColor.withValues(alpha: 0.10)),
                  onClocCommonListViewItemWidget(
                    onClocSettingsIcon,
                    onClocLocale.lblSettings,
                    themeController.isDarkMode,
                    theme,
                    () {
                      Get.toNamed(OnClocRoutes.onClocSettingsScreen);
                    },
                  ),
                  Divider(color: onClocGreyColor.withValues(alpha: 0.10)),
                  Obx(
                    () => _buildChildDrawerSwitchWidget(
                      onClocDarkModeIcon,
                      onClocLocale.lblDarkMode,
                      controller.isDarkMode,
                      (value) {
                        controller.isDarkMode.value = value;
                        themeController.toggleTheme();
                        Get.forceAppUpdate();
                      },
                    ),
                  ),
                  Divider(color: onClocGreyColor.withValues(alpha: 0.10)),
                  onClocCommonListViewItemWidget(
                    onClocDocumentIcon,
                    onClocLocale.lblTermsConditionsScreenTitle,
                    themeController.isDarkMode,
                    theme,
                    () {
                      Get.toNamed(OnClocRoutes.onClocTermsConditionsScreen);
                    },
                  ),
                  Divider(color: onClocGreyColor.withValues(alpha: 0.10)),
                  onClocCommonListViewItemWidget(
                    onClocShieldIcon,
                    onClocLocale.lblPrivacyPolicyScreenTitle,
                    themeController.isDarkMode,
                    theme,
                    () {
                      Get.toNamed(OnClocRoutes.onClocPrivacyPolicyScreen);
                    },
                  ),
                  Divider(color: onClocGreyColor.withValues(alpha: 0.10)),
                  _buildLogoutViewItem(() {
                    _showLogoutDialog(context);
                  }),
                  Divider(color: onClocGreyColor.withValues(alpha: 0.10)),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildTopProfilePicView() {
    return Center(
      child: SizedBox(
        height: 110,
        child: Stack(
          children: [
            ClipOval(
              child: onClocPortalCachedImageWidget(
                getStringAsync(avatarPref),
                100,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutViewItem(VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: servpalSecondaryColor.withValues(alpha: 0.10),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          onClocLogoutIcon,
          width: 15,
          height: 15,
          colorFilter: const ColorFilter.mode(
            servpalSecondaryColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: Text(
        onClocLocale.lblLogOut,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: servpalSecondaryColor,
        ),
      ),
    );
  }

  Widget _buildChildDrawerSwitchWidget(
    String leadingIcon,
    String text,
    RxBool switchValue,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        height: 40,
        width: 40,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: onClocGreyColor.withValues(alpha: 0.10),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          leadingIcon,
          width: 15,
          height: 15,
          colorFilter: ColorFilter.mode(
            themeController.isDarkMode ? servpalTextColorDark : servpalTextColorLight,
            BlendMode.srcIn,
          ),
        ),
      ),
      title: Text(
        text,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: themeController.isDarkMode ? servpalTextColorDark : servpalTextColorLight,
        ),
      ),
      trailing: Container(
        width: 20,
        margin: const EdgeInsets.only(right: 8),
        child: Transform.scale(
          scale: 0.9,
          // Adjust the scale factor to change the size
          child: CupertinoSwitch(
            activeTrackColor: servpalTertiaryColor,
            value: switchValue.value,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 25.0, right: 20.0),
            child: Text(
              'Are you sure you want to logout?',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                color:
                    Get.isDarkMode
                        ? servpalTextColorDark
                        : servpalTextColorLight,
              ),
            ),
          ),
          actions: <Widget>[
            15.height,
            Divider(
              color:
                  Get.isDarkMode
                      ? servpalBgColorLight.withValues(alpha: 0.10)
                      : onClocGreyColor.withValues(alpha: 0.20),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  // Perform logout operation
                  Navigator.of(context).pop(); // Close dialog
                  onClocSharedHelper.logout();
                },
                child: Text(
                  'Logout',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: servpalSecondaryColor,
                  ),
                ),
              ),
            ),
            Divider(
              color:
                  Get.isDarkMode
                      ? servpalBgColorLight.withValues(alpha: 0.10)
                      : onClocGreyColor.withValues(alpha: 0.20),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text(
                  'Cancel',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color:
                        Get.isDarkMode
                            ? servpalTextColorDark
                            : servpalTextColorLight,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
