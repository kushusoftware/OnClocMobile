class ApiResponseFields {
  static const String statusCode = 'statusCode';
  static const String isSuccess = 'isSuccess';
  static const String message = 'message';
  static const String data = 'data';

  static const List<String> allFields = [
    statusCode,
    isSuccess,
    message,
    data,
  ];
}

class ApiResponse{
  final int statusCode;
  final bool isSuccess;
  final String? message;
  final dynamic data;

  ApiResponse({
    required this.statusCode,
    required this.isSuccess, 
    this.message,
    this.data});
  
  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    statusCode: (json[ApiResponseFields.statusCode] as num).toInt(),
    isSuccess: json[ApiResponseFields.isSuccess] as bool,
    message: json[ApiResponseFields.message] as String?,
    data: json[ApiResponseFields.data],
  );

  Map<String, dynamic> toJson(ApiResponse instance) => {
    ApiResponseFields.statusCode: instance.statusCode,
    ApiResponseFields.isSuccess: instance.isSuccess,
    ApiResponseFields.message: instance.message,
    ApiResponseFields.data: instance.data,
  };
}