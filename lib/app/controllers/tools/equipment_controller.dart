import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/models/tools/equipment_model.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';

class OnClocEquipmentController extends GetxController {
  var equipmentList = <OnClocEquipment>[].obs;
  var customerEquipmentList = <OnClocEquipment>[].obs;
  var serviceEquipmentList = <OnClocEquipment>[].obs;

  Future<RxList<OnClocEquipment>> getCustomerEquipmentList() async {
    customerEquipmentList.clear();
    // Simulate fetching data from a database or API
    await Future.delayed(Duration(seconds: 1));
    customerEquipmentList = filterEquipmentByOwnership('customer').obs;
    return customerEquipmentList;
  }

  Future<RxList<OnClocEquipment>> getServiceEquipmentList() async {
    serviceEquipmentList.clear();
    // Simulate fetching data from a database or API
    await Future.delayed(Duration(seconds: 1));
    serviceEquipmentList = filterEquipmentByOwnership('service').obs;
    return serviceEquipmentList;
  }

  void addEquipment(OnClocEquipment equipment) {
    equipmentList.add(equipment);
  }

  void removeEquipment(OnClocEquipment equipment) {
    equipmentList.remove(equipment);
  }

  List<OnClocEquipment> filterEquipmentByOwnership(String ownership) {
    return equipmentList
        .where((equipment) => equipment.equipmentOwnership == ownership)
        .toList();
  }

  Future<void> getEquipment() async {
    equipmentList.clear();
    // Fetch equipment from API or database
    //equipmentList = await onClocApiService.getEquipment();

    // For now, we will use a local JSON file for testing
    String jasonData = await rootBundle.loadString(onClocEquipmentData);
    dynamic data = json.decode(jasonData);
    List<dynamic> jsonArray = data['equipment'];

    equipmentList =
        jsonArray.map((json) => OnClocEquipment.fromJson(json)).toList().obs;
  }
}
