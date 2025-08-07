import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/views/device/device_verification_screen.dart';
import 'package:on_cloc_mobile/app/views/client/client_profile_screen.dart';
import 'package:on_cloc_mobile/app/views/feedback/feedback_home_screen.dart';
import 'package:on_cloc_mobile/app/views/home/navigation_screen.dart';
import 'package:on_cloc_mobile/app/views/home/privacy_policy_screen.dart';
import 'package:on_cloc_mobile/app/views/home/terms_of_use_screen.dart';
import 'package:on_cloc_mobile/app/views/location/get_location_screen.dart';
import 'package:on_cloc_mobile/app/views/login/two_factor_authentication_screen.dart';
import 'package:on_cloc_mobile/app/views/offline/offline_mode_screen.dart';
import 'package:on_cloc_mobile/app/views/offline/server_unreachable_screen.dart';
import 'package:on_cloc_mobile/app/views/profile/change_password_screen.dart';
import 'package:on_cloc_mobile/app/views/profile/user_notification_screen.dart';
import 'package:on_cloc_mobile/app/views/project/job_card_create_screen.dart';
import 'package:on_cloc_mobile/app/views/project/job_card_detail_screen.dart';
import 'package:on_cloc_mobile/app/views/project/job_card_screen.dart';
import 'package:on_cloc_mobile/app/views/login/forgot_password_screen.dart';
import 'package:on_cloc_mobile/app/views/login/login_screen.dart';
import 'package:on_cloc_mobile/app/views/login/otp_verify_screeen.dart';
import 'package:on_cloc_mobile/app/views/profile/user_activity_screen.dart';
import 'package:on_cloc_mobile/app/views/profile/user_profile_screen.dart';
import 'package:on_cloc_mobile/app/views/device/device_status_screen.dart';
import 'package:on_cloc_mobile/app/views/settings/language_selection_screen.dart';
import 'package:on_cloc_mobile/app/views/profile/enrol_screen.dart';
import 'package:on_cloc_mobile/app/views/settings/settings_screen.dart';
import 'package:on_cloc_mobile/app/views/home/home_screen.dart';
import 'package:on_cloc_mobile/app/views/start/splash_screen.dart';
import 'package:on_cloc_mobile/app/views/task/task_detail_screen.dart';
import 'package:on_cloc_mobile/app/views/task/task_home_screen.dart';
import 'package:on_cloc_mobile/app/views/timesheet/timesheet_screen.dart';
import 'package:on_cloc_mobile/app/views/tools/equipment_screen.dart';
import 'package:on_cloc_mobile/app/views/travel/travel_itinerary_screen.dart';
import 'package:on_cloc_mobile/app/views/weather/weather_forecast_screen.dart';
import 'package:on_cloc_mobile/app/views/work/work_attendance_screen.dart';
import 'package:on_cloc_mobile/app/views/work/work_visit_screen.dart';
import 'package:on_cloc_mobile/app/views/ticket/ticket_home_screen.dart';
import 'package:on_cloc_mobile/app/views/ticket/ticket_create_screen.dart';
import 'package:on_cloc_mobile/app/views/ticket/ticket_detail_screen.dart';
import 'package:on_cloc_mobile/app/views/ticket/ticket_handling_screen.dart';

class OnClocRoutes {
  // Customer Registry
  static const onClocClientProfileScreen = '/ClientProfileScreen';
  static const onClocFeedbackHomeScreen = '/FeedbackHomeScreen';

  static const onClocSplashScreen = '/SplashScreen';
  static const onClocLoginScreen = '/LoginScreen';
  static const onClocHomeScreen = '/HomeScreen';
  static const onClocEnrolScreen = '/EnrolScreen';
  static const onClocForgotPasswordScreen = '/ForgotPasswordScreen';
  static const onClocOtpVerifyScreen = '/OtpVerifyScreen';
  static const onClocNavigationScreen = '/NavigationScreen';
  static const onClocUserNotificationScreen = '/NotificationScreen';
  static const onClocJobCardScreen = '/JobCardScreen';
  static const onClocUserActivityScreen = '/UserActivityScreen';
  static const onClocTravelItineraryScreen = '/TravelItineraryScreen';
  static const onClocTimesheetScreen = '/TimesheetScreen';
  static const onClocUserProfileScreen = '/ProfileScreen';
  static const onClocChangePasswordScreen = '/ChangePasswordScreen';
  static const onClocTermsConditionsScreen = '/TermsConditionScreen';
  static const onClocPrivacyPolicyScreen = '/PrivacyPolicyScreen';
  static const onClocSettingsScreen = '/SettingsScreen';
  static const onClocJobCardCreateScreen = '/JobCardCreateScreen';
  static const onClocJobCardDetailScreen = '/JobCardDetailScreen';
  static const onClocEquipmentScreen = '/EquipmentScreen';
  static const onClocLanguageSelectionScreen = '/LanguageSelectionScreen';
  static const onClocDeviceStatusScreen = '/DeviceStatusScreen';
  static const onClocServerUnreachableScreen = '/ServerUnreachableScreen';
  static const onClocOfflineModeScreen = '/OfflineModeScreen';
  static const onClocDeviceVerificationScreen = '/DeviceVerificationScreen';
  static const onClocTwoFactorAuthenticationScreen =
      '/TwoFactorAuthenticationScreen';
  static const onClocWeatherForecastScreen = '/WeatherForecastScreen';
  static const onClocWorkAttendanceScreen = '/WorkAttendanceScreen';
  static const onClocWorkVisitScreen = '/WorkVisitScreen';

  // Ticket Registry
  static const onClocTicketHomeScreen = '/TicketHomeScreen';
  static const onClocTicketCreateScreen = '/TicketCreateScreen';
  static const onClocTicketDetailScreen = '/TicketDetailScreen';
  static const onClocTicketHandlingScreen = '/TicketHandlingScreen';

  // Task Registry
  static const onClocTaskHomeScreen = '/TaskHomeScreen';
  static const onClocTaskDetailScreen = '/TaskDetailScreen';

  // Location Services
  static const onClocGetLocationScreen = '/GetLocationScreen';

  static final routes = [
    // Customer Registry
    GetPage(
      name: onClocFeedbackHomeScreen,
      page: () => const OnClocFeedbackHomeScreen(),
    ),
    GetPage(
      name: onClocClientProfileScreen,
      page: () => const OnClocClientProfileScreen(),
    ),

    GetPage(name: onClocSplashScreen, page: () => const OnClocSplashScreen()),
    GetPage(name: onClocLoginScreen, page: () => const OnClocLoginScreen()),
    GetPage(name: onClocHomeScreen, page: () => const OnClocHomeScreen()),
    GetPage(
      name: onClocForgotPasswordScreen,
      page: () => const OnClocForgotPasswordScreen(),
    ),
    GetPage(
      name: onClocOtpVerifyScreen,
      page: () => const OnClocOtpVerifyScreen(),
    ),
    GetPage(name: onClocEnrolScreen, page: () => const OnClocEnrolScreen()),
    GetPage(
      name: onClocNavigationScreen,
      page: () => const OnClocNavigationScreen(),
    ),
    GetPage(
      name: onClocUserNotificationScreen,
      page: () => const OnClocUserNotificationScreen(),
    ),
    GetPage(name: onClocJobCardScreen, page: () => const OnClocJobCardScreen()),
    GetPage(
      name: onClocUserActivityScreen,
      page: () => const OnClocUserActivityScreen(),
    ),
    GetPage(
      name: onClocTravelItineraryScreen,
      page: () => const OnClocTravelItineraryScreen(),
    ),
    GetPage(
      name: onClocTimesheetScreen,
      page: () => const OnClocTimesheetScreen(),
    ),
    GetPage(
      name: onClocUserProfileScreen,
      page: () => const OnClocUserProfileScreen(),
    ),
    GetPage(
      name: onClocChangePasswordScreen,
      page: () => const OnClocChangePasswordScreen(),
    ),
    GetPage(
      name: onClocTermsConditionsScreen,
      page: () => const OnClocTermsOfUseScreen(),
    ),
    GetPage(
      name: onClocPrivacyPolicyScreen,
      page: () => const OnClocPrivacyPolicyScreen(),
    ),
    GetPage(
      name: onClocSettingsScreen,
      page: () => const OnClocSettingsScreen(),
    ),
    GetPage(
      name: onClocJobCardCreateScreen,
      page: () => const OnClocJobCardCreateScreen(),
    ),
    GetPage(
      name: onClocJobCardDetailScreen,
      page: () => const OnClocJobCardDetailScreen(),
    ),
    GetPage(
      name: onClocEquipmentScreen,
      page: () => const OnClocEquipmentScreen(),
    ),
    GetPage(
      name: onClocDeviceStatusScreen,
      page: () => const OnClocDeviceStatusScreen(),
    ),
    GetPage(
      name: onClocLanguageSelectionScreen,
      page: () => const OnClocLanguageSelectionScreen(),
    ),
    GetPage(
      name: onClocServerUnreachableScreen,
      page: () => const OnClocServerUnreachableScreen(),
    ),
    GetPage(
      name: onClocOfflineModeScreen,
      page: () => const OnClocOfflineModeScreen(),
    ),
    GetPage(
      name: onClocDeviceVerificationScreen,
      page: () => const OnClocDeviceVerificationScreen(),
    ),
    GetPage(
      name: onClocTwoFactorAuthenticationScreen,
      page: () => const OnClocTwoFactorAuthenticationScreen(),
    ),
    GetPage(
      name: onClocWeatherForecastScreen,
      page: () => const WeatherForecastScreen(),
    ),
    GetPage(
      name: onClocWorkAttendanceScreen,
      page: () => const OnClocWorkAttendanceScreen(),
    ),
    GetPage(
      name: onClocWorkVisitScreen,
      page: () => const OnClocWorkVisitScreen(),
    ),

    // Ticket Registry
    GetPage(
      name: onClocTicketHomeScreen,
      page: () => const OnClocTicketHomeScreen(),
    ),
    GetPage(
      name: onClocTicketCreateScreen,
      page: () => const OnClocTicketCreateScreen(),
    ),
    GetPage(
      name: onClocTicketDetailScreen,
      page: () => const OnClocTicketDetailScreen(),
    ),
    GetPage(
      name: onClocTicketHandlingScreen,
      page: () => const OnClocTicketHandlingScreen(),
    ),

    // Task Registry
    GetPage(
      name: onClocTaskHomeScreen,
      page: () => const OnClocTaskHomeScreen(),
    ),
    GetPage(
      name: onClocTaskDetailScreen,
      page: () => const OnClocTaskDetailScreen(),
    ),

    // Location Services
    GetPage(
      name: onClocGetLocationScreen,
      page: () => const OnClocGetLocationScreen(),
    ),
  ];
}
