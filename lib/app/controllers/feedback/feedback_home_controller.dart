import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/models/client/client_feedback.dart';

class OnClocFeedbackHomeController extends GetxController{
  late ClientFeedback feedback;

  @override
  void onInit() {
    super.onInit();
    final arguments = ModalRoute.of(Get.context!)?.settings.arguments ?? Get.arguments;
    if(arguments is ClientFeedback)
    {
          feedback = arguments;
    }
    else if (arguments is Map) {
      feedback = arguments['data'] as ClientFeedback;
    } else {
      // Handle unexpected cases
      throw Exception('invalid arguments passed to OnClocFeedbackHomeController');
    }
  }

  void fetchFeedbackData() {
    // Logic to fetch feedback data from a service or API
    
    // Update the UI accordingly using GetX state management
    update();
  }
}