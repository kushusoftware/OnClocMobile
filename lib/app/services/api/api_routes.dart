import 'package:on_cloc_mobile/app/services/api/api_config.dart';

class OnClocApiRoutes {
  // BaseUrl to change
  // !!! Do not change the port while local testing "http://{internal_ip}:44317/api/V1/" !!!
  // !!! For live deployment just paste the Url like this "https://{your_website_url}/api/V1/" !!!
  static const baseUrl = baseOnClocWebApiUrl;
  // User Registry Endpoints
  static const userRegistryUrl = 'user/';
  static const validateUsernameUrl = '${userRegistryUrl}ValidateUsername';
  static const validatePhoneNumberUrl = '${userRegistryUrl}ValidatePhoneNumber';
  static const remoteLoginUrl = '${userRegistryUrl}Login';
  static const changePasswordUrl = '${userRegistryUrl}ChangePassword';
  // Device Registry Endpoints
  static const deviceRegistryUrl = 'device/';
  static const verifyDeviceUrl = '${deviceRegistryUrl}VerifyDevice';
  static const registerDeviceUrl = '${deviceRegistryUrl}RegisterDevice';
  static const updateDeviceStatusUrl = '${deviceRegistryUrl}UpdateDeviceStatus';
  // Work Registry Endpoints
  static const workRegistryUrl = 'work/';
  static const checkWorkAttendanceUrl = '${workRegistryUrl}CheckWorkAttendance';
  static const updateWorkStatusUrl = '${workRegistryUrl}UpdateWorkStatus';
  static const workCheckInOutUrl = '${workRegistryUrl}WorkCheckInOut';
  static const jobClockInOutUrl = '${workRegistryUrl}JobClockInOut';
  // Systems Registry Endpoints
  static const systemsRegistryUrl = 'systems/';
  static const getAppSettingsUrl = '${systemsRegistryUrl}GetAppSettings';
  static const weatherForecastUrl = '${systemsRegistryUrl}WeatherForecast';
  // Project Registry Endpoints
  static const projectRegistryUrl = 'project/';
  static const getProjectListUrl = '${projectRegistryUrl}GetProjectList';
  static const getJobStatusListUrl = '${projectRegistryUrl}GetJobStatusList';
  static const getJobPriorityListUrl = '${projectRegistryUrl}GetJobPriorityList';
  static const getJobTypeListUrl = '${projectRegistryUrl}GetJobTypeList';
  static const getJobCategoryListUrl = '${projectRegistryUrl}GetJobCategoryList';
  static const getJobClassListUrl = '${projectRegistryUrl}GetJobClassList';
  static const getJobGroupListUrl = '${projectRegistryUrl}GetJobGroupList';
  static const getJobGenreListUrl = '${projectRegistryUrl}GetJobGenreList';
  static const getJobAllocationListUrl = '${projectRegistryUrl}GetJobAllocationList';
  // Technician Registry Endpoints
  static const technicianRegistryUrl = 'technician/';
  static const getServiceDeskListUrl = '${technicianRegistryUrl}GetServiceDeskList';
  // Client Registry Endpoints
  static const clientRegistryUrl = 'client/';
  static const getClientProfilesUrl = '${clientRegistryUrl}GetClientProfiles';
  static const clientsSearch = '${clientRegistryUrl}ClientSearch';
  // Ticket Registry Endpoints
  static const ticketRegistryUrl = 'ticket/';
  static const getServiceTicketsUrl = '${ticketRegistryUrl}GetServiceTickets';
  static const getTicketCategoriesUrl = '${ticketRegistryUrl}GetTicketCategories';
  static const getTicketPrioritiesUrl = '${ticketRegistryUrl}GetTicketPriorities';
  static const createServiceTicketUrl = '${ticketRegistryUrl}CreateServiceTicket';









  //Offline
  static const syncTrackingFromMobile =
      '${baseUrl}offlineTracking/syncTrackingFromMobile';

  // User
  static const profileURL = '${baseUrl}UserProfiles/';
  static const loginWithUidURL = '${baseUrl}loginWithUid';
  static const forgotPasswordURL = '${baseUrl}forgotPassword';
  static const resetPasswordURL = '${baseUrl}resetPassword';
  static const verifyOTPURL = '${baseUrl}verifyOTP';
  static const phoneNumberCheckURL = '${baseUrl}checkPhoneNumber';
  static const getScheduleURL = '${baseUrl}getSchedule';
  static const checkDeviceUid = '${baseUrl}checkUid';
  static const addMessagingTokenURL = '${baseUrl}messagingToken';

  //Task
  static const taskStatusUpdate = '${baseUrl}task/updateStatus';
  static const taskStatusUpdateFile = '${baseUrl}task/updateStatusFile';
  static const getTaskUpdates = '${baseUrl}task/getTaskUpdates';
  static const getJobCards = '${baseUrl}task/GetAll';
  static const startJob = '${baseUrl}task/startTask';
  static const holdJob = '${baseUrl}task/holdTask';
  static const resumeJob = '${baseUrl}task/resumeTask';
  static const completeJob = '${baseUrl}task/completeTask';

  //Notice
  static const getNotices = '${baseUrl}notice/getAll';

  //Product
  static const getProductsURL = '${baseUrl}product/getAll';
  static const getProductCategoriesURL = '${baseUrl}product/getCategories';
  static const getProductsByCategoryURL =
      '${baseUrl}product/getProductsByCategory';

  //Order
  static const placeOrderURL = '${baseUrl}order/create';
  static const getOrdersHistoryURL = '${baseUrl}order/getHistory';
  static const getOrderCounts = '${baseUrl}order/getOrdersCount';

  //Document Requests
  static const getDocumentTypesURL =
      '${baseUrl}documentRequest/getDocumentTypes';
  static const createDocumentRequestURL = '${baseUrl}documentRequest/create';
  static const getDocumentRequestsURL = '${baseUrl}documentRequest/getAll';
  static const deleteDocumentRequestURL = '${baseUrl}documentRequest/delete';
  static const getDocumentFileUrl = '${baseUrl}documentRequest/getFilePath';

  //Forms
  static const getForms = '${baseUrl}forms/getAssignedForms';
  static const submitForm = '${baseUrl}forms/submitForm';

  //Visits
  static const createVisitURL = '${baseUrl}visit/create';
  static const getVisitsHistoryURL = '${baseUrl}visit/getHistory';
  static const getVisitsCount = '${baseUrl}visit/getVisitsCount';


  //Dashboard
  static const getDashboardData = '${baseUrl}getDashboardData';

  //Leave
  static const getLeaveTypesURL = '${baseUrl}getLeaveTypes';
  static const addLeaveRequest = '${baseUrl}createLeaveRequest';
  static const uploadLeaveDocument = '${baseUrl}uploadLeaveDocument';
  static const getLeaveRequests = '${baseUrl}getLeaveRequests';
  static const deleteLeaveRequest = '${baseUrl}deleteLeaveRequest';

  //Attendance
  static const checkInOut = '${baseUrl}attendance/checkInOut';
  static const checkAttendanceStatus = '${baseUrl}attendance/checkStatus';
  static const getAttendanceStatus =
      '${baseUrl}attendance/getAttendanceHistory';
  static const startStopBreak = '${baseUrl}attendance/startStopBreak';
  static const validateGeoLocation = '${baseUrl}attendance/validateGeoLocation';
  static const validateIpAddress = '${baseUrl}attendance/validateIpAddress';
  static const canCheckOut = '${baseUrl}attendance/canCheckOut';
  static const setEarlyCheckoutReason =
      '${baseUrl}attendance/setEarlyCheckoutReason';

  //Qr Attendance
  static const verifyQr = '${baseUrl}qrAttendance/verifyCode';
  static const verifyDynamicQr = '${baseUrl}dynamicQr/verifyCode';

  //TeamChat
  static const postChat = '${baseUrl}chat/postChat';
  static const getChats = '${baseUrl}chat/getChats';
  static const postChatImage = '${baseUrl}chat/postImageChat';

  //Expense
  static const getExpenseTypes = '${baseUrl}expense/getExpenseTypes';
  static const addExpenseRequest = '${baseUrl}expense/createExpenseRequest';
  static const deleteExpenseRequest = '${baseUrl}expense/deleteExpenseRequest';
  static const getExpenseRequest = '${baseUrl}expense/getExpenseRequests';
  static const uploadExpenseDocument =
      '${baseUrl}expense/uploadExpenseDocument';


  //SignBoard
  static const addSignBoardRequest = '${baseUrl}signBoard/createRequest';




}
