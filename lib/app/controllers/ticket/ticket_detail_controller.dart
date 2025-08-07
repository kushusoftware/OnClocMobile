import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/models/ticket/service_ticket.dart';

class OnClocTicketDetailController extends GetxController {
  late ServiceTicket ticket;
  var selectedIndex = 0.obs;
  var isFilled = false.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = ModalRoute.of(Get.context!)?.settings.arguments ?? Get.arguments;
    if(arguments is ServiceTicket)
    {
          ticket = arguments;
    }
    else if (arguments is Map) {
      ticket = arguments['data'] as ServiceTicket;
    } else {
      // Handle unexpected cases
      throw Exception('invalid arguments passed to OnClocServiceTicketDetailsController');
    }
  }

  void updateSelection(int index) {
    selectedIndex.value = index;
    update();
  }
}