import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:on_cloc_mobile/app/models/client/client_profile.dart';
import 'package:on_cloc_mobile/main.dart';

class OnClocWorkVisitController extends GetxController {
  RxBool isLoading = true.obs;
  RxString clientLabel = onClocLocale.lblClient.obs;
  RxBool isClientsExists = true.obs;
  Rx<ClientProfile?> selectedClient = Rx(null);

  Position? position;

  void init() {
    
  }

  Future submit(String filePath, String text, String s) async {
    isLoading.value = true;

    // Position position = await Geolocator.getCurrentPosition(
    //     locationSettings: const LocationSettings(
    //         accuracy: LocationAccuracy.high, distanceFilter: 10));

    // var address = await mapHelper
    //     .getAddress(LatLng(position.latitude, position.longitude));

    // var req = {
    //   'clientId': selectedClient.value!.clientProfileId.toString(),
    //   'remarks': comments,
    //   'latitude': position.latitude.toString(),
    //   'longitude': position.longitude.toString(),
    //   'address': address ?? ''
    // };

    // var result = await onClocApiService.createVisit(req, filePath);
    isLoading.value = false;
    // return result;
  }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   return await Geolocator.getCurrentPosition();
  // }
}