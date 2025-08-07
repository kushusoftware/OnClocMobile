import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/models/profile/user_notification_model.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';

class OnClocUserNotificationController extends GetxController{
  var userNotificationList = <OnClocUserNotification>[];

  Future<List<OnClocUserNotification>> getNotificationList() async {
    userNotificationList.clear();
    await Future.delayed(const Duration(seconds: 1));
    String jsonData = await rootBundle
        .loadString(onClocUserNotificationData);
    dynamic data = json.decode(jsonData);
    List<dynamic> jsonArray = data['user_notifications'];

    userNotificationList = jsonArray
        .map((json) => OnClocUserNotification.fromJson(json))
        .toList();
    return userNotificationList;
  }
}