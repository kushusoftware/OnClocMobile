import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/profile/user_activity_controller.dart';
import 'package:on_cloc_mobile/app/controllers/theme/theme_controller.dart';
import 'package:on_cloc_mobile/app/models/profile/user_activity_model.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocUserActivityScreen extends StatefulWidget {
  const OnClocUserActivityScreen({super.key});

  @override
  OnClocUserActivityScreenState createState() =>
      OnClocUserActivityScreenState();
}

class OnClocUserActivityScreenState extends State<OnClocUserActivityScreen> {
  OnClocUserActivityController activityController = Get.put(OnClocUserActivityController());
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

double horizontalPadding = 15.0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocUserActivityController>(
      init: activityController,
      tag: 'on_cloc_user_activity',
      builder:
          (_) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: onClocCommonAppBarWidget(
              context,
              titleText: onClocLocale.lblYourActivity,
              actionWidget: InkWell(
                onTap: () async {
                  await activityController.selectStartDate(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    onClocCalendarIcon,
                    colorFilter: ColorFilter.mode(
                      themeController.isDarkMode
                          ? servpalTextColorDark
                          : servpalTextColorLight,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            body: SafeArea(child: getActivityList()),
          ),
    );
  }

  Widget getActivityList() {
    return FutureBuilder<List<OnClocUserActivity>>(
      future: activityController.getActivityList(activityController.selectedDate.value),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: servpalPrimaryColor),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return activityController.filteredActivities.isEmpty
              ? Center(
                child: Text(
                  onClocLocale.lblNoDataAvailable,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: themeController.isDarkMode
                        ? servpalTextColorDark
                        : servpalTextColorLight,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
              : Obx(() => ListView.builder(
                itemCount: activityController.filteredActivities.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  OnClocUserActivity data = activityController.filteredActivities[index];
                  return Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color:
                          themeController.isDarkMode
                              ? servpalSecondaryColor
                              : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 110,
                          offset: const Offset(0, 55),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: servpalPrimaryColor.withValues(alpha: 0.10),
                          ),
                          padding: const EdgeInsets.all(8),
                          width: 40,
                          height: 40,
                          child: SvgPicture.asset(
                            getActivityIcon(data.activityType),
                            width: 18,
                            height: 18,
                            colorFilter: ColorFilter.mode(
                              themeController.isDarkMode
                                  ? servpalTextColorDark
                                  : servpalTextColorLight,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        10.width,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.activity,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: themeController.isDarkMode
                                      ? servpalTextColorDark
                                      : servpalTextColorLight,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                onClocFormatter.format(data.date),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: onClocGreyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        10.width,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.time,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: themeController.isDarkMode
                                    ? servpalTextColorDark
                                    : servpalTextColorLight,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              data.status,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w300,
                                color: onClocGreyColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            );
        }
      },
    );
  }

  String getActivityIcon(String type) {
    if (type == 'CI') {
      return onClocCheckInIcon;
    } else if (type == 'CO') {
      return onClocCheckoutIcon;
    } else {
      return onClocBreakTimeIcon;
    }
  }
}
