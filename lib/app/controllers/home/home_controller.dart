import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/models/profile/user_activity_model.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';

class OnClocHomeController extends GetxController {
  RxBool isLoading = true.obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  RxInt selectedDateIndex = 0.obs;

  RxBool isShowCheckInButton = true.obs;

  var listOfActivities = <OnClocUserActivity>[];

  void selectDate(DateTime date,int index) {
    selectedDateIndex.value = index;
    selectedDate.value = date;
  }

  Future<List<OnClocUserActivity>> getActivityList() async {
    listOfActivities.clear();
    
    String jsonData = await rootBundle
        .loadString(onClocUserActivitiesData);
    dynamic data = json.decode(jsonData);
    List<dynamic> jsonArray = data['user_activities'];

    listOfActivities = jsonArray
        .map((json) => OnClocUserActivity.fromJson(json))
        .toList()
        .cast<OnClocUserActivity>();

    return listOfActivities;
  }
}