import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/components/side_drawer_component.dart';
import 'package:on_cloc_mobile/app/controllers/home/home_controller.dart';
import 'package:on_cloc_mobile/app/controllers/theme/theme_controller.dart';
import 'package:on_cloc_mobile/app/models/profile/user_activity_model.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocHomeScreen extends StatefulWidget {
  const OnClocHomeScreen({super.key});

  @override
  OnClocHomeScreenState createState() => OnClocHomeScreenState();
}

class OnClocHomeScreenState extends State<OnClocHomeScreen> {
  OnClocHomeController controller = Get.put(OnClocHomeController());
  final OnClocThemeController themeController = Get.put(
    OnClocThemeController(),
  );
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  final appBarHeight = AppBar().preferredSize.height;
  final int numberOfDays = 15;
  final double horizontalPadding = 20.0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocHomeController>(
      init: controller,
      tag: 'on_cloc_home',
      builder:
          (value) => Scaffold(
            backgroundColor:
                themeController.isDarkMode
                    ? servpalBgColorDark
                    : servpalBgColorLight,
            appBar: _buildAppBar(),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCalendarView(),
                    Container(
                      decoration: BoxDecoration(
                        color:
                            themeController.isDarkMode
                                ? onClocGreyColor.withValues(alpha: 0.10)
                                : onClocGreyColor.withValues(alpha: 0.05),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          15.height,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                            ),
                            child: Text(
                              onClocLocale.lblWorkAttendanceScreenTitle,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color:
                                    themeController.isDarkMode
                                        ? servpalTextColorDark
                                        : servpalTextColorLight,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          15.height,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: _buildJobCardChildView(
                                    onClocCheckInIcon,
                                    onClocLocale.lblCheckIn,
                                    '10:20 am',
                                    'On Time',
                                  ),
                                ),
                                15.width,
                                Expanded(
                                  child: _buildJobCardChildView(
                                    onClocCheckoutIcon,
                                    onClocLocale.lblCheckOut,
                                    '06:30 pm',
                                    'On Time',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          15.height,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: _buildJobCardChildView(
                                    onClocBreakTimeIcon,
                                    onClocLocale.lblBreakTime,
                                    '00:30 min',
                                    'Avg Time 30 min',
                                  ),
                                ),
                                15.width,
                                Expanded(
                                  child: _buildJobCardChildView(
                                    onClocCalendarIcon,
                                    onClocLocale.lblTotalDays,
                                    '28',
                                    'Working Days',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          15.height,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: horizontalPadding,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  onClocLocale.lblYourActivity,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color:
                                        themeController.isDarkMode
                                            ? servpalTextColorDark
                                            : servpalTextColorLight,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      OnClocRoutes.onClocUserActivityScreen,
                                    );
                                  },
                                  child: Text(
                                    onClocLocale.lblViewAll,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color:
                                          themeController.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          15.height,
                          getUserActivityList(),
                          100.height,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            drawer: Drawer(child: OnClocSideDrawerComponent()),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: _buildCheckInOutButtonView(),
          ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight + 20),
      child: Container(
        color:
            themeController.isDarkMode
                ? servpalBgColorDark
                : servpalBgColorLight,
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          trailing: InkWell(
            onTap: () {
              Get.toNamed(OnClocRoutes.onClocUserNotificationScreen);
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 1.5,
                  color: onClocGreyColor.withValues(alpha: 0.20),
                ),
              ),
              padding: const EdgeInsets.all(12),
              child: SvgPicture.asset(
                onClocNotificationIcon,
                colorFilter: ColorFilter.mode(
                  themeController.isDarkMode
                      ? servpalTextColorDark
                      : servpalTextColorLight,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          leading: Builder(
            builder:
                (context) => IconButton(
                  icon: ClipOval(
                    clipper: ProfilePicClipper(),
                    child: onClocPortalCachedImageWidget(
                      getStringAsync(avatarPref),
                      50,
                      width: 50,
                    ),
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
          ),
          title: Text(
            '${getStringAsync(firstNamePref)} ${getStringAsync(lastNamePref)}',
            style: theme.textTheme.titleLarge?.copyWith(
              color:
                  themeController.isDarkMode
                      ? servpalTextColorDark
                      : servpalTextColorLight,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            getStringAsync(emailPref),
            style: theme.textTheme.bodyMedium?.copyWith(
              color:
                  themeController.isDarkMode
                      ? servpalTextColorDark
                      : servpalTextColorLight,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarView() {
    return Container(
      color:
          themeController.isDarkMode ? servpalBgColorDark : servpalBgColorLight,
      child: HorizontalList(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: 20,
        ),
        itemCount: numberOfDays,
        itemBuilder: (context, index) {
          // Calculate the date for the current index
          DateTime date = DateTime.now().add(Duration(days: index));

          return Obx(
            () => GestureDetector(
              onTap: () {
                controller.selectDate(date, index);
              },
              child: Container(
                height: 70,
                width: 70, // Adjust the width as needed
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        (controller.selectedDateIndex.value == index)
                            ? servpalSecondaryColor
                            : onClocGreyColor.withValues(alpha: 0.20),
                  ),
                  color:
                      (controller.selectedDateIndex.value == index)
                          ? servpalSecondaryColor
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${date.day}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color:
                            (controller.selectedDateIndex.value == index)
                                ? Colors.white
                                : themeController.isDarkMode
                                ? servpalTextColorDark
                                : servpalTextColorLight,
                      ),
                    ),
                    Text(
                      _getWeekday(date.weekday),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w300,
                        color:
                            (controller.selectedDateIndex.value == index)
                                ? Colors.white
                                : themeController.isDarkMode
                                ? servpalTextColorDark
                                : servpalTextColorLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  Widget _buildJobCardChildView(
    String assetName,
    String title,
    String timing,
    String bottomText,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        color:
            themeController.isDarkMode
                ? servpalBgColorDark
                : servpalBgColorLight,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 110,
            offset: const Offset(0, 55),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: servpalSecondaryColor.withValues(alpha: 0.10),
                ),
                padding: const EdgeInsets.all(8),
                width: 34,
                height: 34,
                child: SvgPicture.asset(
                  assetName,
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
              5.width,
              Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  color:
                      themeController.isDarkMode
                          ? servpalTextColorDark
                          : servpalTextColorLight,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          8.height,
          Text(
            timing,
            style: theme.textTheme.bodyLarge?.copyWith(
              color:
                  themeController.isDarkMode
                      ? servpalTextColorDark
                      : servpalTextColorLight,
              fontWeight: FontWeight.w500,
            ),
          ),
          5.height,
          Text(
            bottomText,
            style: theme.textTheme.bodySmall?.copyWith(
              color:
                  themeController.isDarkMode
                      ? servpalTextColorDark
                      : servpalTextColorLight,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget getUserActivityList() {
    return Center(
      child: FutureBuilder<List<OnClocUserActivity>>(
        future: controller.getActivityList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(color: servpalPrimaryColor);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return controller.listOfActivities.isEmpty
                ? Text(onClocLocale.lblNoDataAvailable)
                : ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.listOfActivities.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    OnClocUserActivity data =
                        controller.listOfActivities[index];
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            themeController.isDarkMode
                                ? servpalSecondaryColorDark
                                : servpalSecondaryColorLight,
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
                              color: servpalPrimaryColor.withValues(
                                alpha: 0.10,
                              ),
                            ),
                            padding: const EdgeInsets.all(8),
                            width: 40,
                            height: 40,
                            child: SvgPicture.asset(
                              getActivityIcon(data.activityType),
                              width: 18,
                              height: 18,
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
                                  DateFormat('MMM dd,yyyy').format(data.date),
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
                );
          }
        },
      ),
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

  Widget _buildCheckInOutButtonView() {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(
          left: horizontalPadding,
          right: horizontalPadding,
          bottom: 20,
        ),
        child: ActionSlider.standard(
          height: 56,
          backgroundBorderRadius: BorderRadius.circular(10),
          sliderBehavior: SliderBehavior.stretch,
          rolling: true,
          width: 300.0,
          backgroundColor:
              controller.isShowCheckInButton.value
                  ? servpalPrimaryColor
                  : servpalSecondaryColor,
          toggleColor: Colors.transparent,
          iconAlignment: Alignment.centerRight,
          loadingIcon: const SizedBox(
            width: 55,
            child: Center(
              child: SizedBox(
                width: 24.0,
                height: 24.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          successIcon: const SizedBox(
            width: 55,
            child: Center(
              child: Icon(Icons.check_rounded, color: Colors.white),
            ),
          ),
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset(
                onClocArrowRightIcon,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  controller.isShowCheckInButton.value
                      ? servpalPrimaryColor
                      : servpalSecondaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          action: (animatedController) async {
            controller.isShowCheckInButton.value =
                !controller.isShowCheckInButton.value;
            animatedController.loading(); //starts loading animation
            await Future.delayed(const Duration(seconds: 2));
            animatedController.success(); //starts success animation
            await Future.delayed(const Duration(seconds: 1));
            animatedController.reset(); //resets the slider
          },
          child: Text(
            controller.isShowCheckInButton.value
                ? onClocLocale.lblSwipeCheckIn
                : onClocLocale.lblSwipeCheckOut,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilePicClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    var heightCentre = size.height / 2;
    var widthCentre = size.width / 2;
    double radius = 0;
    if (heightCentre > widthCentre) {
      radius = widthCentre;
    } else {
      radius = heightCentre;
    }
    return Rect.fromCircle(
      center: Offset(widthCentre, heightCentre),
      radius: radius,
    );
  }

  @override
  bool shouldReclip(oldClipper) => false;
}
