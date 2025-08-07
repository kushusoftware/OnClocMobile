import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/models/api/requests/work_attendance_request.dart';
import 'package:on_cloc_mobile/app/models/work/work_attendance.dart';
import 'package:on_cloc_mobile/app/models/tracking/work_tracking.dart';
import 'package:on_cloc_mobile/locale/locale_key.dart';
import 'package:on_cloc_mobile/locale/localization.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:public_ip_address/public_ip_address.dart';

class OnClocMainStore extends GetxController{
  RxString selectedLanguageCode = defaultLanguage.obs;
  RxBool isStatusCheckLoading = true.obs;
  RxBool isInOutBtnLoading = false.obs;
  RxBool isBreakBtnLoading = false.obs;

  Rx<WorkAttendance?> currentStatus = WorkAttendance().obs;

  WorkAttendance? get getCurrentStatus => currentStatus.value;

  final Location currentLocation = Location();

  @override
  void onInit() {
    super.onInit();
    
    selectedLanguageCode.value = getStringAsync(languagePref, defaultValue: defaultLanguage);
    setLanguage(selectedLanguageCode.value);
  }

  Future<void> setLanguage(String languageCode, {BuildContext? context}) async {
    selectedLanguageCode.value = languageCode;
    if(context != null){onClocLocale = OnClocLocaleKey.of(context);}
    await setValue(languagePref, languageCode);
    selectedLanguageDataModel = getSelectedLanguageModel();
    onClocLocale = await const OnClocLocalization().load(Locale(languageCode));
  }

  void setCurrentStatus(WorkAttendance status) {
    isStatusCheckLoading.value = true;
    currentStatus.value = status;
    isStatusCheckLoading.value = false;
  }

  Future<void> refreshWorkStatus() async {
    isStatusCheckLoading.value = true;
    await checkWorkAttendance();
    isStatusCheckLoading.value = false;
  }

  Future<void> checkWorkAttendance() async {
    var request = WorkAttendanceRequest(
      serviceOfficerProfileId: getStringAsync(serviceOfficeProfileIdPref)
    );
    var statusResult = await onClocApiService.checkWorkAttendance(request);
    if (statusResult != null) {
      setCurrentStatus(statusResult);
    }
  }

  bool get isCheckedIn {
    if (currentStatus.value != null && currentStatus.value!.status == 'checkedin') {
      return true;
    } else {
      return false;
    }
  }

  bool get isCheckedOut {
    if (currentStatus.value != null && currentStatus.value!.status == 'checkedout') {
      return true;
    } else {
      return false;
    }
  }

  String get travelledDistance {
    if (currentStatus.value != null && currentStatus.value!.travelledDistance != null) {
      return currentStatus.value!.travelledDistance!.toStringAsFixed(0);
    } else {
      return '';
    }
  }

  String get siteName {
    if (currentStatus.value != null && currentStatus.value!.siteName != null) {
      return currentStatus.value!.siteName!;
    } else {
      return '';
    }
  }

  String get trackedHours {
    if (currentStatus.value != null && currentStatus.value!.trackedHours != null) {
      return currentStatus.value!.trackedHours.toString();
    } else {
      return '';
    }
  }

  DateTime get breakStartAt {
    if (isOnBreak) {
      var format = DateFormat('dd-MM-yy HH:mm:ss a');

      var nowDateString = DateFormat('dd-MM-yy').format(DateTime.now());

      return format.parse('$nowDateString ${currentStatus.value!.breakStartedAt}');
    } else {
      return DateTime.now();
    }
  }

  bool get isOnBreak {
    if (currentStatus.value != null &&
        currentStatus.value!.isOnBreak != null &&
        currentStatus.value!.isOnBreak!) {
      return true;
    } else {
      return false;
    }
  }

  String get shiftStartAt {
    if (currentStatus.value != null && currentStatus.value!.shiftStartAt != null) {
      return currentStatus.value!.shiftStartAt!;
    } else {
      return '';
    }
  }

  String get shiftEndAt {
    if (currentStatus.value != null && currentStatus.value!.shiftEndAt != null) {
      return currentStatus.value!.shiftEndAt!;
    } else {
      return '';
    }
  }

  Future checkInOut(WorkStatus status, {String? lateCheckInReason}) async {
    isInOutBtnLoading.value = true;

    var location = await currentLocation.getLocation();
    if (location.latitude == null || location.longitude == null) {
      toast('Unable to get device location');
      return false;
    }

    var battery = Battery();

    var connectivityResult = await (Connectivity().checkConnectivity());
    bool onCellNetowrk = connectivityResult.any((e) => e == ConnectivityResult.mobile);
    bool onWifiNetwork = connectivityResult.any((e) => e == ConnectivityResult.wifi);
    WorkTracking workTracking = WorkTracking(
      serviceOfficerProfileId: getStringAsync(serviceOfficeProfileIdPref),
      workTrackingId: '',
      workAttendanceId: '',
      latitude: location.latitude!,
      longitude: location.longitude!,
      accuracy: location.accuracy ?? 0,
      altitude: location.altitude ?? 0,
      heading: location.heading ?? 0,
      speed: location.speed ?? 0,
      time: location.time ?? 0,
      activity: 'unknown',
      status: status == WorkStatus.checkIn ? 'checkedin' : 'checkedout',
      isMock: location.isMock ?? false,
      batteryPercentage: await battery.batteryLevel,
      signalStrength: onCellNetowrk ? 5 : 0,
      isGpsEnabled: true,
      isWifiEnabled: onWifiNetwork,
      isSynced: false,
      createdAt: DateTime.now(),
    );

    var result = await onClocApiService.workCheckInOut(workTracking);
    if (!result) {
      return false;
    }
    await checkWorkAttendance();
    if (status == WorkStatus.checkIn) {
      onClocTrackingService.startLocationTrackingService();
    } else {
      onClocTrackingService.stopLocationTrackingService();
    }
    toast(
      'Successfully ${status == WorkStatus.checkIn ? 'checked in' : 'checked out'}',
    );
    isInOutBtnLoading.value = false;
    return true;
  }

  Future<bool> startStopBreak() async {
    isBreakBtnLoading.value = true;
    var result = await onClocApiService.startStopBreak();
    await refreshWorkStatus();
    if (result) {
      isInOutBtnLoading.value = false;
      return false;
    }
    isBreakBtnLoading.value = false;
    return true;
  }

  AttendanceType get attendanceType {
    if (currentStatus.value != null && currentStatus.value!.attendanceType != null) {
      switch (currentStatus.value!.attendanceType!) {
        case 'geofence':
          return AttendanceType.geofence;
        case 'ip':
          return AttendanceType.ipAddress;
        case 'staticqrcode':
          return AttendanceType.qr;
        case 'dynamicqrcode':
          return AttendanceType.dynamicQr;
        default:
          return AttendanceType.none;
      }
    } else {
      return AttendanceType.none;
    }
  }

  Future<bool> validateIpAddress() async {
    isInOutBtnLoading.value = true;
    var ipAdd = IpAddress();
    var ip = await ipAdd.getIp();
    var result = await onClocApiService.validateIpAddress(ip);
    if (result) {
      toast('Your IP address is verified');
      isInOutBtnLoading.value = false;
      return true;
    } else {
      toast('You are not in the IP address range');
    }
    isInOutBtnLoading.value = false;
    return false;
  }

  Future<bool> validateGeofence() async {
    isInOutBtnLoading.value = true;
    var location = await currentLocation.getLocation();
    if (location.latitude == null || location.longitude == null) {
      toast('Unable to get device location');
      isInOutBtnLoading.value = false;
      return false;
    }
    var result = await onClocApiService.validateGeofence(
      location.latitude!,
      location.longitude!,
    );
    if (result) {
      toast('Your location is verified');
      isInOutBtnLoading.value = false;
      return true;
    }

    toast('You are not in the geofence area');
    isInOutBtnLoading.value = false;
    return false;
  }

  Future<bool> validateQrCode(String qrCode) async {
    isInOutBtnLoading.value = true;
    var result = await onClocApiService.verifyQr(qrCode);
    if (result) {
      isInOutBtnLoading.value = false;
      toast('Your QR code is verified');
      return true;
    }
    isInOutBtnLoading.value = false;
    return false;
  }

  Future<bool> validateDynamicQrCode(String qrCode) async {
    isInOutBtnLoading.value = true;
    var result = await onClocApiService.verifyDynamicQr(qrCode);
    if (result) {
      isInOutBtnLoading.value = false;
      toast('Your QR code is verified');
      return true;
    }
    isInOutBtnLoading.value = false;
    return false;
  }
}

enum WorkStatus { checkIn, checkOut, newJob }

enum AttendanceType { geofence, ipAddress, none, qr, dynamicQr }