import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/models/travel/travel_itinerary_model.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';

class OnClocTravelItineraryController extends GetxController {
  var travelItineraryList = <OnClocTravelItinerary>[].obs;

  Future<List<OnClocTravelItinerary>> getTravelItineraryList() async {
    travelItineraryList.clear();
    // Fetch data from API or database

    String jsonData = await rootBundle.loadString(onClocTravelItineraryData);
    dynamic data = json.decode(jsonData);
    List<dynamic> jsonArray = data['travel_itinerary'];

    travelItineraryList = jsonArray
        .map((json) => OnClocTravelItinerary.fromJson(json))
        .toList().obs;
    return travelItineraryList;
  }
}