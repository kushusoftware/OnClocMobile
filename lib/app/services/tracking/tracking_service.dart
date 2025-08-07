import 'dart:async';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter_activity_recognition/models/activity.dart';
import 'package:flutter_activity_recognition/models/activity_confidence.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart' as loctn;
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/models/device/device_status.dart';
import 'package:on_cloc_mobile/app/models/tracking/work_tracking.dart';
import 'package:on_cloc_mobile/app/models/work/work_status.dart';
import 'package:on_cloc_mobile/app/services/location/location_service.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class OnClocTrackingService {
  int updateCount = 0;
  bool permissionGranted = false;
  bool gpsEnabled = false;
  bool trackingServiceEnabled = false;
  Battery battery = Battery();
  loctn.Location locationInfo = loctn.Location();
  List<loctn.LocationData> locationList = [];

  late StreamSubscription<loctn.LocationData> locationSubscription;

  // This class is a singleton, so it can be used anywhere in the app.
  static final OnClocTrackingService _instance =
      OnClocTrackingService._internal();

  factory OnClocTrackingService() {
    return _instance;
  }

  // This is the private constructor that is used to create the singleton instance.
  OnClocTrackingService._internal();

  Future updateDeviceStatus(double latitude, double longitude) async {
    // Instantiate it
    var battery = Battery();
    var connectivityResult = await Connectivity().checkConnectivity();
    var gpsStatus = await Geolocator.isLocationServiceEnabled();
    DeviceStatus deviceStatus = DeviceStatus(
      batteryPercentage: await battery.batteryLevel,
      isGpsEnabled: gpsStatus,
      isWifiEnabled: connectivityResult.any((e) => e == ConnectivityResult.wifi),
      signalStrength: 5,
      latitude: latitude,
      longitude: longitude,
      isOnLine: true,
    );
    await onClocApiService.updateDeviceStatus(deviceStatus);
  }

  Future updateWorkStatus(
    Activity activity,
    double latitude,
    double longitude,
  ) async {
    updateCount++;
    if (mainStore.getCurrentStatus != null &&
        mainStore.getCurrentStatus!.status == 'checkedin') {}
    int confidence = 0;
    switch (activity.confidence) {
      case ActivityConfidence.HIGH:
        confidence = 100;
        break;
      case ActivityConfidence.MEDIUM:
        confidence = 50;
        break;
      case ActivityConfidence.LOW:
        confidence = 20;
        break;
    }

    var gpsStatus = true;
    WorkStatus workStatus = WorkStatus(
      status: 'string',
      accuracy: confidence,
      activity: activity.type.toString(),
      latitude: latitude,
      longitude: longitude,
      altitude: 0,
      heading: 0,
      locationAccuracy: 0,
      speed: 0,
      time: 0,
      isMock: false,
      batteryPercentage: await battery.batteryLevel,
      isGpsEnabled: gpsStatus,
      isWifiEnabled: false,
      signalStrength: 4,
    );
    log('Work Status Update >> ');
    log(workStatus);

    final connectivityResult = await (Connectivity().checkConnectivity());
    bool onCellNetowrk = connectivityResult.any((e) => e == ConnectivityResult.mobile);
    bool onWifiNetwork = connectivityResult.any((e) => e == ConnectivityResult.wifi);
    if (onCellNetowrk || onWifiNetwork) {
      await onClocApiService.updateWorkStatus(workStatus);
    } else {
      var batteryPercentage = await battery.batteryLevel;
      var now = DateTime.now();
      var trackingData = WorkTracking(
        serviceOfficerProfileId: getStringAsync(serviceOfficeProfileIdPref),
        workTrackingId: '',
        workAttendanceId: '',
        status: 'status',
        accuracy: confidence.toDouble(),
        activity: activity.type.toString(),
        latitude: latitude,
        longitude: longitude,
        altitude: 0,
        heading: 0,
        speed: 0,
        time: 0,
        isMock: false,
        batteryPercentage: batteryPercentage,
        isGpsEnabled: gpsStatus,
        isWifiEnabled: false,
        signalStrength: 4,
        isSynced: false,
        createdAt: now,
      );
      await onClocDbService.createWorkTracking(trackingData);
    }
  }

  Future checkPermissionStatus() async {
    bool isPermissionGranted = await checkPermissionGranted();
    bool isGpsEnabled = await checkGpsEnabled();
    permissionGranted = isPermissionGranted;
    gpsEnabled = isGpsEnabled;
    if (permissionGranted && gpsEnabled) {
      trackingServiceEnabled = true;
    } else {
      trackingServiceEnabled = false;
    }
  }

  Future<bool> checkPermissionGranted() async {
    return await Permission.locationWhenInUse.isGranted;
  }

  Future<bool> checkGpsEnabled() async {
    return await Permission.location.serviceStatus.isEnabled;
  }

  Future<Position> getCurrentLocation() async {
    // This method is used to get the current location of the device.
    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
    return position;
  }

  void requestLocationPermission() async {
    // This method is used to request the location permission from the user.
    PermissionStatus permissionStatus =
        await Permission.locationWhenInUse.request();
    if (permissionStatus == PermissionStatus.granted) {
      permissionGranted = true;
    } else {
      permissionGranted = false;
    }
  }

  void requestEnableGps() async {
    if (!gpsEnabled) {
      bool isGpsEnabled = await locationInfo.requestService();
      if (isGpsEnabled) {
        gpsEnabled = true;
      } else {
        gpsEnabled = false;
      }
    }
  }

  void addLocation(loctn.LocationData locationData) {
    // This method is used to add the location data to the list of location data.
    locationList.add(locationData);
  }

  void clearLocationData() {
    // This method is used to clear the list of location data.
    locationList.clear();
  }

  Future startLocationTrackingService() async {
    // Check location permission is granted and GPS is enabled
    await checkPermissionStatus();

    final bgService = FlutterBackgroundService();
    var isRunning = await bgService.isRunning();
    if (!isRunning) {
      bgService.startService();
    }

    if (permissionGranted && gpsEnabled) {
      locationSubscription = locationInfo.onLocationChanged
      .listen((loctn.LocationData currentLocation) => Repo().update(currentLocation));
      trackingServiceEnabled = true;
      // locationSubscription = locationInfo.onLocationChanged
      //     .listen((loctn.LocationData currentLocation) {
      //   addLocation(currentLocation);
        // Send the location data to the server
        //onClocApiService.sendLocationData(currentLocation);
      //});
    } else {
      if (!gpsEnabled) {
        requestEnableGps();
      }
      if (!permissionGranted) {
        requestLocationPermission();
      }
    }

    setValue(isLocationTrackingOnPref, true);
  }

  Future stopLocationTrackingService() async {
    setValue(isLocationTrackingOnPref, false);
    setValue(latitudePref, 0.0);
    setValue(longitudePref, 0.0);
    setValue(locationCountPref, 0);
    setValue(activityCountPref, 0);

    if (trackingServiceEnabled) {
      final bgService = FlutterBackgroundService();
      var isRunning = await bgService.isRunning();
      if (isRunning) {
        bgService.invoke('stopService');
      }
      trackingServiceEnabled = false;
      await locationSubscription.cancel();
      clearLocationData();
    }
  }
}
