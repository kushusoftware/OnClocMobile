import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/controllers/timesheet/timesheet_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocTimesheetScreen extends StatefulWidget {
  const OnClocTimesheetScreen({super.key});

  @override
  State<OnClocTimesheetScreen> createState() => OnClocTimesheetScreenState();
}

class OnClocTimesheetScreenState extends State<OnClocTimesheetScreen> {
  final OnClocTimesheetController controller = Get.put(OnClocTimesheetController());
  late ThemeData theme;
  var horizontalPadding = 20.0;

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocTimesheetController>(
      init: controller,
      tag: 'on_cloc_timesheet',
      builder:
          (controller) => Scaffold(
            appBar: onClocCommonAppBarWidget(
              context,
              leadingWidth: 0,
              leadingWidget: const Wrap(),
              isback: false,
              isTitleCenter: false,
              titleText: onClocLocale.lblTimesheetScreenTitle,
              actionWidget: InkWell(
                onTap: () {
                  Get.offNamed(OnClocRoutes.onClocWorkAttendanceScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: SvgPicture.asset(
                    onClocJobIcon
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      color: Colors.white,
                      child: Center(
                        child: Text('Weekly Timesheet')
                        
                      ),
                    ),
                    // Add more widgets here as needed
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
