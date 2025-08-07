import 'package:get/get.dart';

class OnClocGetLocationController extends GetxController {
  final RxString location = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getLocation();
  }

  Future<void> getLocation() async {
    // Simulate a delay for fetching location
    await Future.delayed(const Duration(seconds: 2));
    // Set the location to a dummy value
    location.value = 'Current Location: Latitude 37.7749, Longitude -122.4194';
  }
}