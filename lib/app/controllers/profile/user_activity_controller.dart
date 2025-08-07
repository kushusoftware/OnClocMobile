import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/models/profile/user_activity_model.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';

class OnClocUserActivityController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  var filteredActivities = <OnClocUserActivity>[].obs;
  var listOfActivities = <OnClocUserActivity>[].obs;

  void selectDate(DateTime date, int index) {
    selectedDate.value = date;
  }

  Future<List<OnClocUserActivity>> getActivityList(DateTime date) async {
    filteredActivities.clear();
    listOfActivities.clear();

    String jsonData = await rootBundle.loadString(onClocUserActivitiesData);
    dynamic data = json.decode(jsonData);
    List<dynamic> jsonArray = data['user_activities'];

    listOfActivities =
        jsonArray
            .map((json) => OnClocUserActivity.fromJson(json))
            .toList()
            .cast<OnClocUserActivity>()
            .obs;

    listOfActivities.add(
      OnClocUserActivity(
        id: 1,
        date: DateTime.now(),
        activity: 'Check In',
        activityType: 'CI',
        status: 'on Time',
        time: '09:00 am',
      ),
    );
    listOfActivities.add(
      OnClocUserActivity(
        id: 2,
        date: DateTime.now(),
        activity: 'Break In',
        activityType: 'BT',
        status: 'on Time',
        time: '01:00 pm',
      ),
    );
    listOfActivities.add(
      OnClocUserActivity(
        id: 3,
        date: DateTime.now(),
        activity: 'Break Out',
        activityType: 'BT',
        status: 'on Time',
        time: '01:30 pm',
      ),
    );
    listOfActivities.add(
      OnClocUserActivity(
        id: 4,
        date: DateTime.now(),
        activity: 'Check Out',
        activityType: 'CO',
        status: 'on Time',
        time: '05:30 pm',
      ),
    );

    for (var activity in listOfActivities) {
      if (_isSameDate(activity.date, date)) {
        filteredActivities.add(activity);
      }
    }

    return filteredActivities;
  }

  // Utility function to compare if two dates are the same
  bool _isSameDate(DateTime activityDate, DateTime dateToCompare) {
    return activityDate.year == dateToCompare.year &&
        activityDate.month == dateToCompare.month &&
        activityDate.day == dateToCompare.day;
  }

  // To check if there is any activity for today
  bool isActivityAvailableForToday() {
    return filteredActivities.isNotEmpty;
  }

  Future<void> selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: Get.overlayContext!,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      // Custom theme for the date picker dialog
      builder: (BuildContext context, Widget? child) {
        return Theme(
          // Customize the theme of the date picker dialog here
          data: ThemeData.light().copyWith(
            primaryColor: servpalPrimaryColor,
            // Change primary color
            colorScheme: const ColorScheme.light(primary: servpalPrimaryColor),
            // Change color scheme
            dialogTheme: DialogThemeData(
              backgroundColor: Colors.white,
            ), // Change dialog background color
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedDate.value = picked;
      getActivityList(selectedDate.value);
      update(); // This will update the GetBuilder in the UI
    }
  }
}
