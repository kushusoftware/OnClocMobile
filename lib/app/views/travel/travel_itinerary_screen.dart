import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/travel/travel_itinerary_controller.dart';
import 'package:on_cloc_mobile/app/models/travel/travel_itinerary_model.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocTravelItineraryScreen extends StatefulWidget {
  const OnClocTravelItineraryScreen({super.key});

  @override
  OnClocTravelItineraryScreenState createState() =>
      OnClocTravelItineraryScreenState();
}

class OnClocTravelItineraryScreenState extends State<OnClocTravelItineraryScreen> {
  final OnClocTravelItineraryController travelController = Get.put(OnClocTravelItineraryController());
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
    return GetBuilder<OnClocTravelItineraryController>(
      init: travelController,
      tag: 'on_cloc_travel_itinerary',
      builder:
          (_) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: onClocCommonAppBarWidget(
              context,
              leadingWidth: 0,
              leadingWidget: const Wrap(),
              isback: false,
              isTitleCenter: false,
              titleText: onClocLocale.lblTravelItineraryScreenTitle,
            ),
            body: SafeArea(child: buildTravelItinerary()),
          ),
    );
  }

  Widget buildTravelItinerary() {
    return Center(
      child: FutureBuilder<List<OnClocTravelItinerary>>(
        future: travelController.getTravelItineraryList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(color: servpalPrimaryColor);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return travelController.travelItineraryList.isEmpty
                ? Text(onClocLocale.lblNoDataAvailable)
                : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: travelController.travelItineraryList.length,
                  // shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    OnClocTravelItinerary data =
                        travelController.travelItineraryList[index];
                    return Container(
                      margin: EdgeInsets.only(
                        left: horizontalPadding,
                        top: (index == 0) ? 10 : 8,
                        bottom:
                            (index ==
                                    travelController
                                            .travelItineraryList
                                            .length -
                                        1)
                                ? 50
                                : 8,
                        right: horizontalPadding,
                      ),
                      decoration: BoxDecoration(
                        color:
                            Get.isDarkMode
                                ? onClocGreyColor.withValues(alpha: 0.05)
                                : Colors.white,
                        border: Border.all(
                          color:
                              Get.isDarkMode
                                  ? onClocGreyColor.withValues(alpha: 0.10)
                                  : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 110,
                            offset: const Offset(0, 55),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 12,
                            height: 89,
                            decoration: BoxDecoration(
                              color:
                                  (data.travelStatus.toLowerCase() ==
                                          'approved')
                                      ? servpalPrimaryColor
                                      : Get.isDarkMode
                                      ? Colors.white.withValues(alpha: 0.10)
                                      : servpalPrimaryColor.withValues(
                                        alpha: 0.10,
                                      ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        onClocCalendarIcon,
                                        width: 24,
                                        height: 24,
                                        colorFilter: ColorFilter.mode(
                                          Get.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      10.width,
                                      Expanded(
                                        child: Text(
                                          onClocFormatter.format(
                                            data.travelDate,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      2.width,
                                      Text(
                                        getDayFromDate(data.travelDate),
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color:
                                                  Get.isDarkMode
                                                      ? Colors.white
                                                      : onClocGreyColor,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                      10.width,
                                    ],
                                  ),
                                  5.height,
                                  Text(
                                    data.eventName,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  5.height,
                                  Text(
                                    '${data.travelFrom} - ${data.travelTo}',
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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

  String getDayFromDate(DateTime inputDateTime) {
    // DateTime inputDateTime = DateTime.parse(date);

    // Use the weekday property to get the day of the week (1 for Monday, 7 for Sunday)
    int dayOfWeek = inputDateTime.weekday;

    // Convert day of week to string
    String dayString = _getDayOfWeekString(dayOfWeek);

    return dayString;
  }

  String _getDayOfWeekString(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Unknown';
    }
  }
}
