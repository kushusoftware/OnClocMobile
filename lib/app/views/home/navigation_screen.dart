import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/home/navigation_controller.dart';
import 'package:on_cloc_mobile/app/controllers/theme/theme_controller.dart';
import 'package:on_cloc_mobile/app/views/home/home_screen.dart';
import 'package:on_cloc_mobile/app/views/project/job_card_screen.dart';
import 'package:on_cloc_mobile/app/views/ticket/ticket_home_screen.dart';
import 'package:on_cloc_mobile/app/views/timesheet/timesheet_screen.dart';
import 'package:on_cloc_mobile/app/views/travel/travel_itinerary_screen.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';

class OnClocNavigationScreen extends StatefulWidget {
  const OnClocNavigationScreen({super.key});

  @override
  OnClocNavigationScreenState createState() => OnClocNavigationScreenState();
}

class OnClocNavigationScreenState extends State<OnClocNavigationScreen> with TickerProviderStateMixin {
  OnClocNavigationController controller = Get.put(OnClocNavigationController());
  final OnClocThemeController themeController = Get.put(OnClocThemeController());

  late TabController tabController;
  late ThemeData theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    controller = Get.put(OnClocNavigationController());

    tabController = TabController(length: 5, vsync: this);
    ever(controller.currentIndex, (_) {
      tabController.animateTo(controller.currentIndex.value);
    });

    theme =
        Get.isDarkMode
            ? OnClocTheme.darkTheme
            : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocNavigationController>(
      init: controller,
      tag: 'on_cloc_navigation',
      builder:
          (controller) => Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor:
                themeController.isDarkMode ? servpalPrimaryColor : Colors.white,
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              backgroundColor: servpalSecondaryColor,
              onPressed: () {
                tabController.index = 2;
                controller.currentIndex.value = 2;
              },
              child: SvgPicture.asset(onClocTicketIcon),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              notchMargin: 6,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 53,
              color:
                  themeController.isDarkMode
                      ? servpalBgColorDark
                      : servpalBgColorLight.withValues(alpha: 0.80),
              shape: const CircularNotchedRectangle(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(child: _buildBottomInnerView(0, onClocHomeIcon)),
                  Flexible(child: _buildBottomInnerView(1, onClocJobIcon)),
                  const Spacer(flex: 1),
                  Flexible(child: _buildBottomInnerView(3, onClocTravelIcon)),
                  Flexible(child: _buildBottomInnerView(4, onClocTimesheetIcon)),
                ],
              ),
            ),
            body: SafeArea(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: tabController,
                children: const [
                  OnClocHomeScreen(),
                  OnClocJobCardScreen(),
                  OnClocTicketHomeScreen(),
                  OnClocTravelItineraryScreen(),
                  OnClocTimesheetScreen(),
                ],
              ),
            ),
          ),
    );
  }

  Widget _buildBottomInnerView(int index, String icon) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 4,
            decoration: BoxDecoration(
              color: themeController.isDarkMode
              ? servpalPrimaryColor
              : servpalOptionalColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ).visible((controller.currentIndex.value == index)),
          IconButton(
            icon: SvgPicture.asset(
              icon,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                (controller.currentIndex.value == index)
                    ? onClocBlueGreyColor
                    : themeController.isDarkMode
                    ? servpalTextColorDark
                    : servpalTextColorLight,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              controller.changeTabIndex(index);
            },
          ),
        ],
      ),
    );
  }
}
