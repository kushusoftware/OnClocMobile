import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/profile/user_profile_controller.dart';
import 'package:on_cloc_mobile/app/controllers/theme/theme_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:on_cloc_mobile/widgets/common_text_style.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocUserProfileScreen extends StatefulWidget {
  const OnClocUserProfileScreen({super.key});

  @override
  OnClocUserProfileScreenState createState() => OnClocUserProfileScreenState();
}

class OnClocUserProfileScreenState extends State<OnClocUserProfileScreen> {
  OnClocUserProfileController controller = Get.put(OnClocUserProfileController());
  final OnClocThemeController themeController = Get.find<OnClocThemeController>();
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
    return GetBuilder<OnClocUserProfileController>(
      init: controller,
      tag: 'on_cloc_user_profile',
      builder:
          (_) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: onClocCommonAppBarWidget(
              context,
              titleText: onClocLocale.lblMyProfile,
            ),
            body: SafeArea(
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
                        controller.fullNameController.text,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color:
                              themeController.isDarkMode
                                  ? servpalTextColorDark
                                  : servpalTextColorLight,
                        ),
                      ),
                    ),
                    4.height,
                    Center(
                      child: Text(
                        controller.designationController.text,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w300,
                          color:
                              themeController.isDarkMode
                                  ? servpalTextColorDark
                                  : servpalTextColorLight,
                        ),
                      ),
                    ),
                    20.height,
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            onClocStarIcon,
                            height: 16,
                            width: 16,
                            colorFilter: const ColorFilter.mode(
                              onClocDarkYellowColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          4.width,
                          Text(
                            '4.9',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: onClocDarkYellowColor,
                            ),
                          ),
                          6.width,
                          commonVerticalDivider(),
                          5.width,
                          SvgPicture.asset(
                            onClocBuildingsIcon,
                            height: 18,
                            width: 18,
                            colorFilter: const ColorFilter.mode(
                              onClocDarkYellowColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          8.width,
                          Text(
                            clientName,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color:
                                  themeController.isDarkMode
                                      ? onClocLightGreyColor
                                      : onClocBlueGreyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.height,
                    AbsorbPointer(
                      child: TextField(
                        controller: controller.emailController,
                        decoration: commonDecoration(
                          theme,
                          onClocLocale.lblEmailAddress,
                        ),
                      ),
                    ),
                    10.height,
                    AbsorbPointer(
                      child: TextField(
                        controller: controller.contactNumberController,
                        decoration: commonDecoration(
                          theme,
                          onClocLocale.lblContactNumber,
                        ),
                      ),
                    ),
                    10.height,
                    AbsorbPointer(
                      child: TextField(
                        controller: controller.employeeIdController,
                        decoration: commonDecoration(theme, onClocLocale.lblEmployeeId),
                      ),
                    ),
                    10.height,
                    AbsorbPointer(
                      child: TextField(
                        controller: controller.departmentController,
                        decoration: commonDecoration(theme, onClocLocale.lblDepartment),
                      ),
                    ),
                    10.height,
                    AbsorbPointer(
                      child: TextField(
                        controller: controller.reportingManagerController,
                        decoration: commonDecoration(theme, onClocLocale.lblReportingManager),
                      ),
                    ),
                    10.height,
                    AbsorbPointer(
                      child: TextField(
                        controller: controller.companyEmailController,
                        decoration: commonDecoration(
                          theme,
                          onClocLocale.lblCompanyEmailAddress,
                        ),
                      ),
                    ),
                    10.height,
                    AbsorbPointer(
                      child: TextField(
                        controller: controller.companyContactController,
                        decoration: commonDecoration(
                          theme,
                          onClocLocale.lblCompanyContactNumber,
                        ),
                      ),
                    ),
                    10.height,
                    AbsorbPointer(
                      child: TextField(
                        controller: controller.companyOfficeTimeController,
                        decoration: commonDecoration(
                          theme,
                          onClocLocale.lblCompanyOfficeTime,
                        ),
                      ),
                    ),
                  ],
                ),
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
                controller.avatorController.text,
                100,
                width: 100,
              ),
            ),
            Positioned(
              right: 10,
              bottom: 0,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: themeController.isDarkMode
                    ? servpalSecondaryColor.withValues(alpha: 0.80)
                    : servpalPrimaryColor.withValues(alpha: 0.80),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: SvgPicture.asset(
                    onClocCameraIcon,
                    colorFilter: const ColorFilter.mode(
                      onClocWhiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
