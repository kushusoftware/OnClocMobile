import 'package:flutter/material.dart';

abstract class OnClocLocaleKey {
  static OnClocLocaleKey of(BuildContext context) =>
      Localizations.of<OnClocLocaleKey>(context, OnClocLocaleKey)!;

  String get lblDarkMode;

  // ### Connectivity ###
  String get lblNoInternetConnection;
  String get lblPleaseTryAgain;
  String get lblBackOnline;
  String get lblServerUnreachable;
  String get lblOfflineMode;
  String get lblYouAreInOfflineMode;
  String get lblOfflineModeLimitedOptions;

  // ### Data ###
  String get lblNoDataAvailable;
  String get lblLocationNotEnabled;

  // ### Common ###
  String get lblClient;
  String get lblGoBack;
  String get lblFilter;
  String get lblStatus;
  String get lblReset;
  String get lblApply;
  String get lblReject;
  String get lblAccept;
  String get lblSearch;
  String get lblCall;
  String get lblDelete;
  String get lblEmail;
  String get lblSubject;
  String get lblDescription;
  String get lblDate;
  String get lblTime;
  String get lblDateAndTime;
  String get lblDueDateAndTime;
  String get lblFrom;
  String get lblTo;
  String get lblApprovedBy;
  String get lblContactNumber;
  String get lblLocation;
  String get lblUpdate;
  String get lblRefresh;
  String get lblRetry;
  String get lblHoldOn;
  String get lblOk;
  String get lblCancel;
  String get lblYes;
  String get lblDone;
  String get lblNo;
  String get lblNote;
  String get lblRemarks;
  String get lblLoadingPleaseWait;
  String get lblImageIsRequired;
  String get lblCommentIsRequired;
  String get lblSubmit;
  String get lblSubmittedSuccessfully;
  String get lblTasks;
  String get lblReviews;
  String get lblRelatedClients;
  String get lblHandleTicket;
  String get lblDuration;
  String get lblRating;
  String get lblThisFieldIsRequired;
  String get lblFillAllRequiredFields;
  String get lblError;
  String get lblNext;
  String get lblPrevious;
  String get lblChooseLocationFromMap;
  String get lblMustBeAtLeast5Characters;
  String get lblMustNotExceed20Characters;
  String get lblInvalidDateFormat;

  // ### Policy ###
  String get lblPrivacyPolicyScreenTitle;
  String get lblTermsConditionsScreenTitle;

  // ### Profile ###
  String get lblMyProfile;
  String get lblEditProfile;
  String get lblChangePassword;
  String get lblSettings;
  String get lblCompanyEmailAddress;
  String get lblCompanyContactNumber;
  String get lblCompanyOfficeTime;
  String get lblEmployeeId;
  String get lblDepartment;
  String get lblReportingManager;

  // ### Login ###
  String get lblLogIn;
  String get lblLogOut;
  String get lblLoginSuccessful;
  String get lblLoggedOutSuccessfully;
  String get lblUserLockedOut;
  String get lblEnrol;
  String get lblPleaseEnterEmail;
  String get lblPleaseEnterValidCredentials;
  String get lblPleaseEnterPassword;
  String get lblPleaseEnterValidPassword;
  String get lblWelcomeBack;
  String get lblUserName;
  String get lblPassword;
  String get lblConfirmPassword;
  String get lblForgotPassword;
  String get lblRememberMe;
  String get lblVerification;
  String get lblAccount;
  String get lblEmailAddress;
  String get lblEmailIsNotRegistered;
  String get lblUsernamePasswordInvalid;
  String get lbldoNotHaveAccount;
  String get lblNotificationTitle;
  String get lblLoginToContinue;
  String get lblContinueText;
  String get lblForgotPasswordWithEmoji;
  String get lblSelectContactDetailsToResetPassword;

  // ### Home ###
  String get lblJobCardsTitle;
  String get lblCheckIn;
  String get lblCheckOut;
  String get lblBreakTime;
  String get lblTotalDays;
  String get lblYourActivity;
  String get lblViewAll;
  String get lblSwipeCheckIn;
  String get lblSwipeCheckOut;

  // ### Job Card ###
  String get lblJobCardScreenTitle;
  String get lblJobCardDetails;
  String get lblOpenJobsTitle;
  String get lblUpcomingJobsTitle;
  String get lblOnHoldJobsTitle;
  String get lblCompletedJobsTitle;
  String get lblCheckInFirst;
  String get lblNoJobCardsAvailable;
  String get lblJobNumber;
  String get lblProjectTitle;
  String get lblSelectServiceProject;
  String get lblServiceDeskTitle;
  String get lblSelectServiceDesk;
  String get lblJobTypeTitle;
  String get lblSelectJobType;
  String get lblJobCategoryTitle;
  String get lblSelectJobCategory;
  String get lblJobClassTitle;
  String get lblSelectJobClass;
  String get lblJobGroupTitle;
  String get lblSelectJobGroup;
  String get lblJobGenreTitle;
  String get lblSelectJobGenre;
  String get lblJobCardCreateScreenTitle;

  // ### Service Ticket ###
  String get lblTicket;
  String get lblServiceTicketScreenTitle;
  String get lblTicketCategoryTitle;
  String get lblTicketPriorityTitle;
  String get lblSelectServiceTicket;
  String get lblAddServiceTicket;
  String get lblCreateServiceTicket;
  String get lblServiceTicketDetails;
  String get lblSelectClientProfile;
  String get lblSelectTicketCategory;
  String get lblSelectTicketPriority;
  String get lblTicketCreatedSuccessfully;
  String get lblTicketCreationFailed;
  String get lblCloseTicket;
  String get lblConfirmCloseTicket;
  String get lblConfirmCloseTicketDescription;
  String get lblConfirmCloseTicketTerms;
  String get lblTicketInformation;
  String get lblClientFeedback;
  String get lblNoClientFeedbackAvailable;
  String get lblTechnicalRemarks;
  String get lblServiceRemarks;
  String get lblTaskInstruction;

  // ### Travel Itinerary ###
  String get lblTravelItineraryScreenTitle;

  // ### Equipment ###
  String get lblEquipmentScreenTitle;
  String get lblEquipmentCustomer;
  String get lblEquipmentService;

  // ### Settings ###
  String get lblSettingsScreenTitle;
  String get lblDeviceStatusTitle;
  String get lblRefreshAppConfiguration;
  String get lblAppSettingsRefreshedSuccessfully;
  String get lblFailedToRefreshAppSettings;
  String get lblLanguage;
  String get lblLanguageSelectionTitle;
  String get lblWeatherForecast;

  // ### Change Password ###
  String get lblChangePasswordScreenTitle;
  String get lblPasswordIsRequired;
  String get lblPasswordMustBeAtLeast8CharactersLong;
  String get lblConfirmPasswordIsRequired;
  String get lblPasswordsDoNotMatch;
  String get lblPasswordChangedSuccessfully;

  // Device Verifciation
  String get lblDeviceVerificationTitle;
  String get lblNewDevice;
  String get lblRegisterDevice;
  String get lblDeviceRegisteredSuccessfully;
  String get lblUnableToCheckDeviceStatus;
  String get lblUnableToRegisterDevice;
  String get lblVerifyingDevice;
  String get lblVerificationPending;
  String get lblYourDeviceVerificationIsPending;
  String get lblDeviceVerificationFailed;
  String
  get lblThisDeviceIsAlreadyRegisteredWithOtherAccountPleaseContactAdministrator;
  String get lblThisDeviceIsNotRegisteredClickOnRegisterToAddItToYourAccount;
  String get lblVerificationCompleted;
  String get lblYourDeviceVerificationIsSuccessfullyCompleted;
  String get lblVerificationFailedPleaseTryAgain;
  String get lblDeviceRegistrationDisabled;

  // Timesheet
  String get lblTimesheetScreenTitle;

  // Work Attendance
  String get lblOpenSecuritySettings;
  String get lblWorkAttendanceScreenTitle;
  String get lblScanYourFingerprintToCheckIn;
  String get lblFingerprintAuthentication;
  String get lblAuthenticateWithFingerprintOrPasswordToProceed;
  String get lblFingerprintOrPinVerificationIsRequiredForCheckInAndOut;
  String get lblMarkVisit;
  String get lblAttendanceStatus;
  String get lblAttendanceInAt;
  String get lblAttendanceOutAt;
  String get lblCheckInToBegin;
  String get lblAreYouSureYouWantToCheckIn;
  String get lblAreYouSureYouWantToCheckOut;
  String get lblAllDoneForToday;

  // Work Visit
  String get lblWorkVisitScreenTitle;
  String get lblAddClient;
  String get lblClickToAddImage;
  String get lblToMarkVisitsPleaseAddClient;

  // ### Task ###
  String get lblTasksScreenTitle;
  String get lblOpenTasks;
  String get lblCompletedTasks;
}
