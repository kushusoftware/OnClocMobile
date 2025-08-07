import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/models/api/requests/work_attendance_request.dart';
import 'package:on_cloc_mobile/app/models/tracking/work_tracking.dart';
import 'package:on_cloc_mobile/app/models/work/work_attendance.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';

class OnClocWorkAttendanceController extends GetxController{
  RxBool isLoading = true.obs;

  final Location locationService = Location();

  late StreamSubscription<LocationData> locationSubscription;


  Future<WorkAttendance> checkWorkAttendance() async {
    isLoading.value = true;
    var request = WorkAttendanceRequest(
      serviceOfficerProfileId: getStringAsync(serviceOfficeProfileIdPref)
    );
    var statusResponse = await onClocApiService.checkWorkAttendance(request);
    if (statusResponse != null) {
      mainStore.setCurrentStatus(statusResponse);
    }
    isLoading.value = false;
    return statusResponse!;
  }

  Future checkInOut(String status) async {
    isLoading.value = true;

    var location = await locationService.getLocation();
    var battery = Battery();

    var connectivityResult = await (Connectivity().checkConnectivity());
    var request = WorkTracking(
      serviceOfficerProfileId: getStringAsync(serviceOfficeProfileIdPref),
      status: status,
      latitude: location.latitude,
      longitude: location.longitude,
      altitude: location.altitude ?? 0,
      heading: 0,
      accuracy: location.accuracy ?? 0,
      speed: location.speed ?? 0,
      time: location.time ?? 0,
      isMock: location.isMock ?? false,
      batteryPercentage: await battery.batteryLevel,
      isGpsEnabled: true,
      isWifiEnabled: connectivityResult.contains(ConnectivityResult.wifi),
      signalStrength: connectivityResult.contains(ConnectivityResult.mobile) ? 5 : 0,
      isSynced: false,
      createdAt: DateTime.now(),
    );


    // Map req = {
    //   "status": status,
    //   "latitude": location.latitude,
    //   "longitude": location.longitude,
    //   "altitude": location.altitude ?? 0,
    //   "bearing": 0,
    //   "locationAccuracy": location.accuracy ?? 0,
    //   "speed": location.speed ?? 0,
    //   "time": location.time ?? 0,
    //   "isMock": location.isMock ?? false,
    //   "batteryPercentage": await battery.batteryLevel,
    //   "isLocationOn": true,
    //   "isWifiOn": connectivityResult == ConnectivityResult.wifi,
    //   "signalStrength": connectivityResult == ConnectivityResult.mobile ? 5 : 0
    // };

    var result = await onClocApiService.workCheckInOut(request);
    if (!result) {
      return false;
    }
    await checkWorkAttendance();
    if (status == 'checkin') {
      onClocTrackingService.startLocationTrackingService();
    } else {
      onClocTrackingService.stopLocationTrackingService();
    }
    toast('Successfully $status');
    isLoading.value = false;
    return true;
  }


}