import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException, rootBundle;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:location/location.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/components/work_attendance_component.dart';
import 'package:on_cloc_mobile/app/controllers/work/work_attendance_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';
import 'package:open_settings_plus/open_settings_plus.dart';

class OnClocWorkAttendanceScreen extends StatefulWidget {
  const OnClocWorkAttendanceScreen({super.key});

  @override
  State<OnClocWorkAttendanceScreen> createState() =>
      OnClocWorkAttendanceScreenState();
}

class OnClocWorkAttendanceScreenState
    extends State<OnClocWorkAttendanceScreen> {
  OnClocWorkAttendanceController controller = Get.put(
    OnClocWorkAttendanceController(),
  );
  final LatLng _initialCameraPosition = const LatLng(
    0.32016793409858446,
    32.61129114834035,
  );

  late ThemeData theme;

  late LocationData _currentPosition;
  late GoogleMapController _mapController;
  List<Marker> markers = [];
  var mMapType = MapType.normal;
  late String _darkMapStyle = '';
  late String _lightMapStyle = '';

  //Local Auth
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unsupported;
  bool _canCheckBiometrics = false;
  bool _isAuthenticating = false;
  List<BiometricType> _availableBiometrics = [];
  bool _authorized = false;

  var now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadMapStyles();
    init();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  void init() async {
    controller.checkWorkAttendance();
    auth.isDeviceSupported().then((bool isSupported) {
      if (isSupported) {
        setState(() {
          _supportState = _SupportState.supported;
        });
        _checkBiometrics();
        if (_canCheckBiometrics) {
          _getAvailableBiometrics();
        }
      } else {
        _supportState = _SupportState.unsupported;
      }
    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    controller.locationSubscription.cancel();
    super.dispose();
  }

  void updateMarkers(Set<Marker> markers) {
    this.markers = markers.toList();
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      log(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      log(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
      });

      authenticated = await auth.authenticate(
        localizedReason: onClocLocale.lblScanYourFingerprintToCheckIn,
        options: const AuthenticationOptions(stickyAuth: true),
        authMessages: <AuthMessages>[
          /*   IOSAuthMessages(
              cancelButton: onClocLocale.lblCancel,
              goToSettingsButton: onClocLocale.lblSettings,
              goToSettingsDescription: onClocLocale.lblPleaseSetUpYourTouchId,
              lockOut: onClocLocale.lblPleaseReEnableYourTouchId,
            ),*/
          AndroidAuthMessages(
            signInTitle: onClocLocale.lblFingerprintAuthentication,
            //fingerprintRequiredTitle: "Connect to Login",
            cancelButton: onClocLocale.lblCancel,
            goToSettingsButton: onClocLocale.lblSettings,
            goToSettingsDescription: 'Please setup your fingerprint',
            biometricRequiredTitle:
                onClocLocale.lblAuthenticateWithFingerprintOrPasswordToProceed,
            //fingerprintSuccess: "Authentication Successfully authenticated",
          ),
        ],
      );
      if (_availableBiometrics.isNotEmpty) {
        _authenticateWithBiometrics();
      }
      _authorized = authenticated;
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      log('Auth error$e');
    }
    if (!mounted) return false;

    setState(() {
      _authorized = authenticated;
    });
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint or face to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      log('Error: $e');
      setState(() {
        _isAuthenticating = false;
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _authorized = authenticated;
    });
  }

  void _onMapCreated(GoogleMapController mapController) {
    _mapController = mapController;
    controller.locationSubscription = controller
        .locationService
        .onLocationChanged
        .listen((l) {
          _mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(l.latitude!, l.longitude!),
                zoom: 15,
              ),
            ),
          );
        });
  }

  void getLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await controller.locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await controller.locationService.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await controller.locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await controller.locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await controller.locationService.getLocation();
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            _currentPosition.latitude!,
            _currentPosition.longitude!,
          ),
          zoom: 15,
        ),
      ),
    );
  }

  Future _loadMapStyles() async {
    _darkMapStyle = await rootBundle.loadString(onClocMapStyleDark);
    _lightMapStyle = await rootBundle.loadString(onClocMapStyleLight);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final AlertDialog setPinDialog = AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      title: Text(
        onClocLocale.lblNote,
        style: boldTextStyle(
          color: Get.isDarkMode ? servpalTextColorDark : servpalTextColorLight,
        ),
      ),
      content: Text(
        onClocLocale.lblFingerprintOrPinVerificationIsRequiredForCheckInAndOut,
        style: secondaryTextStyle(
          color: onClocGreyColor.withValues(alpha: 0.6),
        ),
      ),
      actions: [
        TextButton(
          child: Text(
            onClocLocale.lblOpenSecuritySettings,
            style: primaryTextStyle(),
          ),
          onPressed: () {
            switch (OpenSettingsPlus.shared) {
              case OpenSettingsPlusAndroid settings:
                settings.security();
                break;
              case OpenSettingsPlusIOS settings:
                settings.accountSettings();
                break;
              default:
                throw Exception('Unsupported platform');
            }
          },
        ),
        TextButton(
          child: Text(
            onClocLocale.lblOk,
            style: primaryTextStyle(
              color: Get.isDarkMode
                  ? servpalPrimaryColorDark
                  : servpalPrimaryColorLight,
            ),
          ),
          onPressed: () {
            finish(context);
          },
        ),
      ],
    );

    return GetBuilder<OnClocWorkAttendanceController>(
      init: controller,
      tag: 'on_cloc_work_attendance',
      builder: (_) => Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialCameraPosition,
              ),
              mapType: MapType.normal,
              minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
              style: Get.isDarkMode ? _darkMapStyle : _lightMapStyle,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
            Obx(
              () =>
                  (mainStore.getCurrentStatus!.status != 'new' &&
                      mainStore.getCurrentStatus!.status != 'checkedin')
                  ? Positioned(
                      right: 5,
                      bottom: 150,
                      child:
                          Card(
                            color: white.withValues(alpha: 0.8),
                            elevation: 5,
                            shape: buildRoundedCorner(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  const Icon(Icons.add_a_photo, size: 40),
                                  Text(onClocLocale.lblMarkVisit),
                                ],
                              ),
                            ),
                          ).onTap(
                            () => Get.offNamed(
                              OnClocRoutes.onClocWorkVisitScreen,
                            ),
                          ),
                    )
                  : Container(),
            ),
            Obx(
              () => !(controller.isLoading.value)
                  ? WorkAttendanceComponent()
                  : Card(
                      color: white.withValues(alpha: 0.4),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            loadingWidgetMaker(),
                            Text(
                              onClocLocale.lblLoadingPleaseWait,
                              style: boldTextStyle(size: 16, color: white),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            Obx(
              () => !controller.isLoading.value
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: [
                              mainStore.getCurrentStatus!.status == 'checkedout'
                                  ? Center(
                                      child: Text(
                                        onClocLocale.lblAllDoneForToday,
                                        style: boldTextStyle(),
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        35.height,
                                        Obx(
                                          () => Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              bottom: 28,
                                            ),
                                            child:
                                                mainStore
                                                        .getCurrentStatus!
                                                        .status ==
                                                    'new'
                                                ? AppButton(
                                                    color: servpalPrimaryColor,
                                                    textColor: Colors.white,
                                                    width: width - 40,
                                                    shapeBorder:
                                                        buildRoundedCorner(),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          onClocLocale
                                                              .lblCheckIn,
                                                          style:
                                                              primaryTextStyle(
                                                                color: white,
                                                              ),
                                                        ),
                                                        5.width,
                                                        const Icon(
                                                          Icons.login,
                                                          color: white,
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () async {
                                                      final bool
                                                      canAuthenticateWithBiometrics =
                                                          await auth
                                                              .canCheckBiometrics;
                                                      final bool
                                                      canAuthenticate =
                                                          canAuthenticateWithBiometrics ||
                                                          await auth
                                                              .isDeviceSupported();
                                                      if (!canAuthenticate) {
                                                        if (!context.mounted) {
                                                          return;
                                                        }
                                                        showConfirmDialogCustom(
                                                          context,
                                                          title: onClocLocale
                                                              .lblAreYouSureYouWantToCheckIn,
                                                          dialogType: DialogType
                                                              .CONFIRMATION,
                                                          positiveText:
                                                              onClocLocale
                                                                  .lblYes,
                                                          negativeText:
                                                              onClocLocale
                                                                  .lblNo,
                                                          onAccept: (c) async {
                                                            await controller
                                                                .checkInOut(
                                                                  'checkin',
                                                                );
                                                          },
                                                        );
                                                        return;
                                                      }
                                                      if (_supportState ==
                                                              _SupportState
                                                                  .supported &&
                                                          _isAuthenticating ==
                                                              false) {
                                                        await _authenticate();
                                                        if (_authorized) {
                                                          if (!context
                                                              .mounted) {
                                                            return;
                                                          }
                                                          showConfirmDialogCustom(
                                                            context,
                                                            title: onClocLocale
                                                                .lblAreYouSureYouWantToCheckIn,
                                                            dialogType: DialogType
                                                                .CONFIRMATION,
                                                            positiveText:
                                                                onClocLocale
                                                                    .lblYes,
                                                            negativeText:
                                                                onClocLocale
                                                                    .lblNo,
                                                            onAccept: (c) async {
                                                              await controller
                                                                  .checkInOut(
                                                                    'checkin',
                                                                  );
                                                            },
                                                          );
                                                          return;
                                                        } else {
                                                          if (!context
                                                              .mounted) {
                                                            return;
                                                          }
                                                          showConfirmDialogCustom(
                                                            context,
                                                            title: onClocLocale
                                                                .lblAreYouSureYouWantToCheckIn,
                                                            dialogType: DialogType
                                                                .CONFIRMATION,
                                                            positiveText:
                                                                onClocLocale
                                                                    .lblYes,
                                                            negativeText:
                                                                onClocLocale
                                                                    .lblNo,
                                                            onAccept: (c) async {
                                                              await controller
                                                                  .checkInOut(
                                                                    'checkin',
                                                                  );
                                                            },
                                                          );
                                                        }
                                                      } else {
                                                        if (!context.mounted) {
                                                          return;
                                                        }
                                                        showDialog(
                                                          context: context,
                                                          builder:
                                                              (
                                                                BuildContext
                                                                context,
                                                              ) {
                                                                return setPinDialog;
                                                              },
                                                        );
                                                      }
                                                    },
                                                  )
                                                : mainStore
                                                          .getCurrentStatus!
                                                          .status ==
                                                      'checkedin'
                                                ? AppButton(
                                                    color: Colors.red.shade600,
                                                    textColor: Colors.white,
                                                    width: width - 40,
                                                    shapeBorder:
                                                        buildButtonCorner(),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          onClocLocale
                                                              .lblCheckOut,
                                                          style:
                                                              primaryTextStyle(
                                                                color: white,
                                                              ),
                                                        ),
                                                        5.width,
                                                        const Icon(
                                                          Icons.logout,
                                                          color: white,
                                                        ),
                                                      ],
                                                    ),
                                                    onTap: () async {
                                                      final bool
                                                      canAuthenticateWithBiometrics =
                                                          await auth
                                                              .canCheckBiometrics;
                                                      final bool
                                                      canAuthenticate =
                                                          canAuthenticateWithBiometrics ||
                                                          await auth
                                                              .isDeviceSupported();
                                                      if (!canAuthenticate) {
                                                        if (!context.mounted) {
                                                          return;
                                                        }
                                                        showConfirmDialogCustom(
                                                          context,
                                                          title: onClocLocale
                                                              .lblAreYouSureYouWantToCheckOut,
                                                          dialogType: DialogType
                                                              .CONFIRMATION,
                                                          positiveText:
                                                              onClocLocale
                                                                  .lblYes,
                                                          negativeText:
                                                              onClocLocale
                                                                  .lblNo,
                                                          onAccept: (c) async {
                                                            await controller
                                                                .checkInOut(
                                                                  'checkout',
                                                                );
                                                          },
                                                        );
                                                        return;
                                                      }
                                                      if (_supportState ==
                                                              _SupportState
                                                                  .supported &&
                                                          _isAuthenticating ==
                                                              false) {
                                                        await _authenticate();
                                                        if (_authorized) {
                                                          if (!context
                                                              .mounted) {
                                                            return;
                                                          }
                                                          showConfirmDialogCustom(
                                                            context,
                                                            title: onClocLocale
                                                                .lblAreYouSureYouWantToCheckOut,
                                                            dialogType: DialogType
                                                                .CONFIRMATION,
                                                            positiveText:
                                                                onClocLocale
                                                                    .lblYes,
                                                            negativeText:
                                                                onClocLocale
                                                                    .lblNo,
                                                            onAccept: (c) async {
                                                              await controller
                                                                  .checkInOut(
                                                                    'checkout',
                                                                  );
                                                            },
                                                          );
                                                          return;
                                                        } else {
                                                          if (!context
                                                              .mounted) {
                                                            return;
                                                          }
                                                          showConfirmDialogCustom(
                                                            context,
                                                            title: onClocLocale
                                                                .lblAreYouSureYouWantToCheckOut,
                                                            dialogType: DialogType
                                                                .CONFIRMATION,
                                                            positiveText:
                                                                onClocLocale
                                                                    .lblYes,
                                                            negativeText:
                                                                onClocLocale
                                                                    .lblNo,
                                                            onAccept: (c) async {
                                                              await controller
                                                                  .checkInOut(
                                                                    'checkout',
                                                                  );
                                                            },
                                                          );
                                                          return;
                                                        }
                                                      } else {
                                                        if (!context.mounted) {
                                                          return;
                                                        }
                                                        showDialog(
                                                          context: context,
                                                          builder:
                                                              (
                                                                BuildContext
                                                                context,
                                                              ) {
                                                                return setPinDialog;
                                                              },
                                                        );
                                                      }
                                                    },
                                                  )
                                                : Container(),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

enum _SupportState { supported, unsupported }
