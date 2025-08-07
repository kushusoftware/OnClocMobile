import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/models/project/job_allocation.dart';

class OnClocJobCardDetailController extends GetxController {
  late JobAllocation jobCard;
  var selectedIndex = 0.obs;

  void selection(int index) {
    selectedIndex.value = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    final arguments = ModalRoute.of(Get.context!)?.settings.arguments ?? Get.arguments;
    if (arguments is JobAllocation) {
      jobCard = arguments;
    } else if (arguments is Map) {
      jobCard = arguments['data'] as JobAllocation;
    } else {
      // Handle unexpected cases
      throw Exception('Invalid arguments passed to OnClocJobCardDetailController');
    }
  }
}