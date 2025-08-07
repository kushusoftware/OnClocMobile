import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/models/api/requests/ticket_create_request.dart';
import 'package:on_cloc_mobile/app/models/api/requests/dropdown_menu_request.dart';
import 'package:on_cloc_mobile/app/models/api/requests/job_allocation_request.dart';
import 'package:on_cloc_mobile/app/models/api/requests/ticket_list_request.dart';
import 'package:on_cloc_mobile/app/models/api/requests/work_attendance_request.dart';
import 'package:on_cloc_mobile/app/models/api/requests/change_password_request.dart';
import 'package:on_cloc_mobile/app/models/api/requests/register_device_request.dart';
import 'package:on_cloc_mobile/app/models/api/requests/verify_device_request.dart';
import 'package:on_cloc_mobile/app/models/device/verify_device_response.dart';
import 'package:on_cloc_mobile/app/models/device/device_status.dart';
import 'package:on_cloc_mobile/app/models/api/requests/validate_phone_number_request.dart';
import 'package:on_cloc_mobile/app/models/api/requests/validate_username_request.dart';
import 'package:on_cloc_mobile/app/models/project/job_allocation.dart';
import 'package:on_cloc_mobile/app/models/project/job_status.dart';
import 'package:on_cloc_mobile/app/models/project/job_category.dart';
import 'package:on_cloc_mobile/app/models/project/job_class.dart';
import 'package:on_cloc_mobile/app/models/project/job_genre.dart';
import 'package:on_cloc_mobile/app/models/project/job_group.dart';
import 'package:on_cloc_mobile/app/models/project/job_priority.dart';
import 'package:on_cloc_mobile/app/models/project/job_type.dart';
import 'package:on_cloc_mobile/app/models/technician/service_desk.dart';
import 'package:on_cloc_mobile/app/models/api/requests/service_desk_list_request.dart';
import 'package:on_cloc_mobile/app/models/ticket/service_ticket.dart';
import 'package:on_cloc_mobile/app/models/ticket/ticket_category.dart';
import 'package:on_cloc_mobile/app/models/ticket/ticket_priority.dart';
import 'package:on_cloc_mobile/app/models/tracking/work_tracking.dart';
import 'package:on_cloc_mobile/app/models/work/work_status.dart';
import 'package:on_cloc_mobile/app/services/api/api_routes.dart';
import 'package:on_cloc_mobile/app/models/api/result/api_response.dart';
import 'package:on_cloc_mobile/app/models/client/client_profile.dart';
import 'package:on_cloc_mobile/app/models/client/on_cloc_client_skip_take.dart';
import 'package:on_cloc_mobile/app/models/login/remote_login_request.dart';
import 'package:on_cloc_mobile/app/models/profile/user_profile_model.dart';
import 'package:on_cloc_mobile/app/models/schedule/on_cloc_schedule.dart';
import 'package:on_cloc_mobile/app/models/settings/app_settings.dart';
import 'package:on_cloc_mobile/app/models/work/work_attendance.dart';
import 'package:on_cloc_mobile/app/models/task/on_cloc_task_update.dart';
import 'package:on_cloc_mobile/app/models/weather/weather_forecast_model.dart';
import 'package:on_cloc_mobile/app/services/network/network_service.dart';
import 'package:on_cloc_mobile/utilities/network.dart';

class OnClocApiService {
  // Check if the response is successful and show messages
  bool checkSuccessStatus(ApiResponse? response, {bool showError = false}) {
    if (!showError && response != null) {
      return response.isSuccess && response.statusCode == 200;
    } else if (showError && response != null) {
      if (response.isSuccess && response.statusCode == 200) {
        if (response.data is String) {
          toast('${response.message}: ${response.data.toString()}');
        } else {
          toast(response.message);
        }
        return true;
      } else {
        toast(response.message);
        return false;
      }
    } else if (!showError && response == null) {
      return false;
    } else if (showError && response == null) {
      toast('...no data returned from server');
      return false;
    } else {
      return false;
    }
  }

  // Get app settings
  Future<OnClocAppSettings?> getAppSettings() async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.getAppSettingsUrl;
    var apiResponse = await networkService.get(endPoint, null);
    var response = await networkService.handleOnClocResponse(apiResponse);
    if (checkSuccessStatus(response)) {
      return OnClocAppSettings.fromJson(response.data);
    } else {
      return null;
    }
  }

  // Validate username
  Future<bool> validateUsername(ValidateUsernameRequest request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.validateUsernameUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.handleOnClocResponse(apiResponse);
    return checkSuccessStatus(response);
  }

  // Validate phone number
  Future<bool> validatePhoneNumber(
    ValidatePhoneNumberRequest request,
  ) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.validatePhoneNumberUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.handleOnClocResponse(apiResponse);
    return checkSuccessStatus(response);
  }

  // Validate username and password
  Future<OnClocUserProfile?> remoteLogin(
    RemoteLoginRequest request,
  ) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.remoteLoginUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.handleOnClocResponse(apiResponse);
    if (checkSuccessStatus(response)) {
      return OnClocUserProfile.fromJson(response.data);
    } else {
      return null;
    }
  }

  // Change password
  Future<bool> changePassword(ChangePasswordRequest request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.changePasswordUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.handleOnClocResponse(apiResponse);
    return checkSuccessStatus(response, showError: true);
  }

  // Verify device
  Future<VerifyDeviceResponse> verifyDevice(
    VerifyDeviceRequest request,
  ) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.verifyDeviceUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.handleOnClocResponse(apiResponse);
    if (checkSuccessStatus(response))
    {
      return VerifyDeviceResponse.fromJson(response.data);
    } else {
      return VerifyDeviceResponse(
        deviceUuid: request.deviceUuid,
        isRegistered: false,
        isEnabled: false,
      );
    }
  }

  // Register device
  Future<bool> registerDevice(RegisterDeviceRequest request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.registerDeviceUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.handleOnClocResponse(apiResponse);
    return checkSuccessStatus(response);
  }

  // Update device status
  Future<bool> updateDeviceStatus(DeviceStatus request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.updateDeviceStatusUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.handleOnClocResponse(apiResponse);
    return checkSuccessStatus(response);
  }

  // Check work status
  Future<WorkAttendance?> checkWorkAttendance(WorkAttendanceRequest request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.checkWorkAttendanceUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.handleOnClocResponse(apiResponse);
    if (!checkSuccessStatus(response)) return null;
    var status = WorkAttendance.fromJson(response.data);
    return status;
  }

  // Update work status
  Future<bool> updateWorkStatus(WorkStatus request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.updateWorkStatusUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.handleOnClocResponse(apiResponse);
    return checkSuccessStatus(response);
  }

  // Check in/out work
  Future<bool> workCheckInOut(WorkTracking request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.workCheckInOutUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.handleOnClocResponse(apiResponse);
    return checkSuccessStatus(response);
  }

  // Get service desks list
  Future<List<ServiceDesk>> getServiceDesks(ServiceDeskListRequest request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.getServiceDeskListUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.processResultList(apiResponse);
    return response.map((m) => ServiceDesk.fromJson(m)).toList();
  }

  // Get job card status list
  Future<List<JobStatus>> getJobStatusList() async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.getJobStatusListUrl;
    var apiResponse = await networkService.get(endPoint, null);
    var response = await networkService.processResultList(apiResponse);
    return response.map((m) => JobStatus.fromJson(m)).toList();
  }

  // Get job card priority list
  Future<List<JobPriority>> getJobPriorityList() async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.getJobPriorityListUrl;
    var apiResponse = await networkService.get(endPoint, null);
    var response = await networkService.processResultList(apiResponse);
    return response.map((m) => JobPriority.fromJson(m)).toList();
  }

  // Get job card type list
  Future<List<JobType>> getJobTypeList() async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.getJobTypeListUrl;
    var apiResponse = await networkService.get(endPoint, null);
    var response = await networkService.processResultList(apiResponse);
    return response.map((m) => JobType.fromJson(m)).toList();
  }

  // Get job card category list
  Future<List<JobCategory>> getJobCategoryList(DropdownMenuRequest request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.getJobCategoryListUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.processResultList(apiResponse);
    return response.map((m) => JobCategory.fromJson(m)).toList();
  }

  // Get job card class list
  Future<List<JobClass>> getJobClassList(DropdownMenuRequest request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.getJobClassListUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.processResultList(apiResponse);
    return response.map((m) => JobClass.fromJson(m)).toList();
  }

  // Get job card group list
  Future<List<JobGroup>> getJobGroupList(DropdownMenuRequest request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.getJobGroupListUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.processResultList(apiResponse);
    return response.map((m) => JobGroup.fromJson(m)).toList();
  }

  // Get job card genre list
  Future<List<JobGenre>> getJobGenreList(DropdownMenuRequest request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.getJobGenreListUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.processResultList(apiResponse);
    return response.map((m) => JobGenre.fromJson(m)).toList();
  }

  // Get job allocation list
  Future<List<JobAllocation>> getJobAllocation(JobAllocationRequest request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.getJobAllocationListUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.processResultList(apiResponse);
    return response.map((m) => JobAllocation.fromJson(m)).toList();
  }

  // Search client list
  Future<List<ClientProfile>> searchClients(String query) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    Map<String, String> fQuery = {'query': query.trim()};
    String endPoint = OnClocApiRoutes.clientsSearch;
    var apiResponse = await networkService.get(endPoint, fQuery);
    var response = await networkService.processResultList(apiResponse);
    return response.map((m) => ClientProfile.fromJson(m)).toList();
  }

  // Get client profiles
  Future<List<ClientProfile>> getClientProfiles() async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.getClientProfilesUrl;
    var apiResponse = await networkService.get(endPoint, null);
    var response = await networkService.processResultList(apiResponse);
    return response.map((m) => ClientProfile.fromJson(m)).toList();
  }

  // Get ticket categories
  Future<List<TicketCategory>> getTicketCategories() async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.getTicketCategoriesUrl;
    var apiResponse = await networkService.get(endPoint, null);
    var response = await networkService.processResultList(apiResponse);
    return response.map((m) => TicketCategory.fromJson(m)).toList();
  }

  // Get ticket priorities
  Future<List<TicketPriority>> getTicketPriorities() async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.getTicketPrioritiesUrl;
    var apiResponse = await networkService.get(endPoint, null);
    var response = await networkService.processResultList(apiResponse);
    return response.map((m) => TicketPriority.fromJson(m)).toList();
  }

  // Create service ticket
  Future<bool> createServiceTicket(CreateTicketRequest request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.createServiceTicketUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.handleOnClocResponse(apiResponse);
    return checkSuccessStatus(response, showError: true);
  }

  // Get service tickets
  Future<List<ServiceTicket>> getServiceTickets(TicketListRequest request) async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.getServiceTicketsUrl;
    dynamic data = request.toJson();
    var apiResponse = await networkService.post(endPoint, data);
    var response = await networkService.processResultList(apiResponse);
    return response.map((m) => ServiceTicket.fromJson(m)).toList();
  }























  Future<bool> resetPassword(Map req) async {
    var result = await handleResponse(
      await postRequest(OnClocApiRoutes.resetPasswordURL, req),
    );
    return checkSuccessStatus(result);
  }

  Future<bool> forgotPassword(String number) async {
    var result = await handleResponse(
      await postRequest(OnClocApiRoutes.forgotPasswordURL, number),
    );
    return checkSuccessStatus(result);
  }

  Future<OnClocUserProfile?> loginWIthUid(String uid) async {
    var response = await handleResponse(
      await postRequest(OnClocApiRoutes.loginWithUidURL, uid),
    );

    if (!checkSuccessStatus(response)) {
      return null;
    }
    var user = OnClocUserProfile.fromJson(response?.data);
    return user;
  }

  Future<bool> verifyOTP(String phoneNumber, String otp) async {
    var payload = {'PhoneNumber': phoneNumber, 'OTP': otp};
    var response = await handleResponse(
      await postRequest(OnClocApiRoutes.verifyOTPURL, payload),
    );
    return checkSuccessStatus(response);
  }

  Future<OnClocSchedule?> getSchedules() async {
    var response = await handleResponse(
      await getRequest(OnClocApiRoutes.getScheduleURL),
    );

    if (!checkSuccessStatus(response)) {
      return null;
    }
    var schedule = OnClocSchedule.fromJson(response?.data);
    return schedule;
  }

  Future<bool> syncTrackingFromMobile(Map req) async {
    var response = await handleResponse(
      await postRequest(OnClocApiRoutes.syncTrackingFromMobile, req),
    );
    return checkSuccessStatus(response);
  }

  // ### Clients ###


  Future<OnClocClientSkipTake?> getClientsWithSkipTake(
    int skip,
    int take,
  ) async {
    Map<String, String> fQuery = {
      'skip': skip.toString(),
      'take': take.toString(),
    };
    var param = Uri(queryParameters: fQuery).query;
    var response = await handleResponse(
      await postRequestWithQuery(OnClocApiRoutes.getClientProfilesUrl, param),
    );
    if (!checkSuccessStatus(response)) return null;

    return OnClocClientSkipTake.fromJson(response!.data);
  }


  // ### Tasks ###
  Future<bool> sendTaskUpdateMsg(
    int taskId,
    String message,
    double latitude,
    double longitude,
  ) async {
    Map<String, String> req = {
      'taskId': taskId.toString(),
      'comment': message,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'taskUpdateType': 'Comment',
    };

    var result = await handleResponse(
      await postRequest(OnClocApiRoutes.taskStatusUpdate, req),
    );

    return checkSuccessStatus(result, showError: true);
  }

  Future<bool> sendTaskUpdateLocation(
    int taskId,
    double latitude,
    double longitude,
  ) async {
    Map<String, String> req = {
      'taskId': taskId.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'taskUpdateType': 'Location',
    };

    var result = await handleResponse(
      await postRequest(OnClocApiRoutes.taskStatusUpdate, req),
    );

    return checkSuccessStatus(result, showError: true);
  }

  Future<bool> sendTaskUpdateImage(
    int taskId,
    String filePath,
    double latitude,
    double longitude,
  ) async {
    Map<String, String> req = {
      'taskId': taskId.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'taskUpdateType': 'Image',
    };

    var result = await multipartRequestWithData(
      OnClocApiRoutes.taskStatusUpdateFile,
      filePath,
      req,
    );

    return result.statusCode == 200;
  }

  Future<bool> sendTaskUpdateFile(
    int taskId,
    String filePath,
    double latitude,
    double longitude,
  ) async {
    Map<String, String> req = {
      'taskId': taskId.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'taskUpdateType': 'Document',
    };

    var result = await multipartRequestWithData(
      OnClocApiRoutes.taskStatusUpdateFile,
      filePath,
      req,
    );

    return result.statusCode == 200;
  }

  Future<List<OnClocTaskUpdate>> getTaskUpdates(int taskId) async {
    Map<String, String> req = {'taskId': taskId.toString()};

    var query = Uri(queryParameters: req).query;

    var result = await handleResponse(
      await postRequestWithQuery(OnClocApiRoutes.getTaskUpdates, query),
    );

    if (!checkSuccessStatus(result)) return [];

    Iterable list = result?.data;

    return list.map((m) => OnClocTaskUpdate.fromJson(m)).toList();
  }

  Future<bool> startJob(
    String jobCardId,
    double latitude,
    double longitude,
  ) async {
    Map<String, String> req = {
      'job_card_id': jobCardId.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };

    var result = await handleResponse(
      await postRequest(OnClocApiRoutes.startJob, req),
    );

    return checkSuccessStatus(result, showError: true);
  }

  Future<bool> holdJob(
    String jobCardId,
    double latitude,
    double longitude,
  ) async {
    Map<String, String> req = {
      'job_card_id': jobCardId.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };

    var result = await handleResponse(
      await postRequest(OnClocApiRoutes.holdJob, req),
    );

    return checkSuccessStatus(result, showError: true);
  }

  Future<bool> resumeJob(
    String jobCardId,
    double latitude,
    double longitude,
  ) async {
    Map<String, String> req = {
      'job_card_id': jobCardId.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };
    var result = await handleResponse(
      await postRequest(OnClocApiRoutes.resumeJob, req),
    );

    return checkSuccessStatus(result, showError: true);
  }

  Future<bool> completeJob(
    String jobCardId,
    double latitude,
    double longitude,
  ) async {
    Map<String, String> req = {
      'job_card_id': jobCardId.toString(),
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };

    var result = await handleResponse(
      await postRequest(OnClocApiRoutes.completeJob, req),
    );

    return checkSuccessStatus(result, showError: true);
  }

  // ### Attendance ###

  Future<bool> verifyDynamicQr(String code) async {
    var response = await handleResponse(
      await postRequest(OnClocApiRoutes.verifyDynamicQr, code),
    );
    return checkSuccessStatus(response, showError: true);
  }

  Future<bool> verifyQr(String code) async {
    var response = await handleResponse(
      await postRequest(OnClocApiRoutes.verifyQr, code),
    );
    return checkSuccessStatus(response, showError: true);
  }

  Future<bool> setEarlyCheckoutReason(String reason) async {
    var response = await handleResponse(
      await postRequest(OnClocApiRoutes.setEarlyCheckoutReason, reason),
    );
    return checkSuccessStatus(response);
  }

  Future<bool> canCheckOut() async {
    var response = await handleResponse(
      await getRequest(OnClocApiRoutes.canCheckOut),
    );

    return checkSuccessStatus(response);
  }

  Future<bool> validateGeofence(double lat, double long) async {
    Map<String, String> req = {
      'latitude': lat.toString(),
      'longitude': long.toString(),
    };

    var query = Uri(queryParameters: req).query;

    var result = await handleResponse(
      await postRequestWithQuery(OnClocApiRoutes.validateGeoLocation, query),
    );
    return checkSuccessStatus(result);
  }

  Future<bool> validateIpAddress(String ip) async {
    Map<String, String> req = {'ipAddress': ip};

    var query = Uri(queryParameters: req).query;

    var result = await handleResponse(
      await postRequestWithQuery(OnClocApiRoutes.validateIpAddress, query),
    );
    return checkSuccessStatus(result);
  }

  Future<bool> startStopBreak() async {
    var response = await handleResponse(
      await postRequest(OnClocApiRoutes.startStopBreak, ''),
    );
    return checkSuccessStatus(response, showError: true);
  }

  Future<List<WeatherForecast>> getWeatherForecast() async {
    OnClocNetworkService networkService = OnClocNetworkService();
    String endPoint = OnClocApiRoutes.weatherForecastUrl;
    var apiResponse = await networkService.get(endPoint, null);
    var response = await networkService.processResultList(apiResponse);
    return response.map((w) => WeatherForecast.fromJson(w)).toList();
  }
}
