import 'package:on_cloc_mobile/app/models/client/client_profile.dart';

class TaskFields {
  static const String id = '_id';
  static const String jobCardTaskId = 'jobCardTaskId';
  static const String taskInstruction = 'taskInstruction';
  static const String description = 'description';
  static const String taskType = 'taskType';
  static const String assignedById = 'assignedById';
  static const String clientId = 'clientId';
  static const String client = 'client';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String isGeoFenceEnabled = 'isGeoFenceEnabled';
  static const String maxRadius = 'maxRadius';
  static const String startDateTime = 'startDateTime';
  static const String endDateTime = 'endDateTime';
  static const String status = 'status';
  static const String forDate = 'forDate';
  static const String isCompleted = 'isCompleted';

  static final List<String> allFields = [
    id,
    taskInstruction,
    description,
    taskType,
    assignedById,
    clientId,
    client,
    latitude,
    longitude,
    isGeoFenceEnabled,
    maxRadius,
    startDateTime,
    endDateTime,
    status,
    forDate,
    isCompleted,
  ];
}

class OnClocTask {
  final int? id;
  final String jobCardTaskId;
  final String taskInstruction;
  final String technicalRemarks;
  final String? taskType;
  final int? assignedById;
  final int? clientId;
  final ClientProfile? client;
  final double? latitude;
  final double? longitude;
  final bool? isGeoFenceEnabled;
  final int? maxRadius;
  final String? startDateTime;
  final String? endDateTime;
  final String? status;
  final String? forDate;
  final bool isCompleted;

  OnClocTask({
    this.id,
    required this.jobCardTaskId,
    required this.taskInstruction,
    required this.technicalRemarks,
    this.taskType,
    this.assignedById,
    this.clientId,
    this.client,
    this.latitude,
    this.longitude,
    this.isGeoFenceEnabled,
    this.maxRadius,
    this.startDateTime,
    this.endDateTime,
    this.status,
    this.forDate,
    required this.isCompleted,
  });

  factory OnClocTask.fromJson(Map<String, dynamic> json) => OnClocTask(
    id: json[TaskFields.id] as int?,
    jobCardTaskId: json[TaskFields.jobCardTaskId] as String,
    taskInstruction: json[TaskFields.taskInstruction] as String,
    technicalRemarks: json[TaskFields.description] as String,
    taskType: json[TaskFields.taskType] as String?,
    assignedById: json[TaskFields.assignedById] as int?,
    clientId: json[TaskFields.clientId] as int?,
    client: json[TaskFields.clientId] != null
        ? ClientProfile.fromJson(json[TaskFields.clientId])
        : null,
    latitude: (json[TaskFields.latitude] as num?)?.toDouble(),
    longitude: (json[TaskFields.longitude] as num?)?.toDouble(),
    isGeoFenceEnabled: json[TaskFields.isGeoFenceEnabled] as bool?,
    maxRadius: json[TaskFields.maxRadius] as int?,
    startDateTime: json[TaskFields.startDateTime] as String?,
    endDateTime: json[TaskFields.endDateTime] as String?,
    status: json[TaskFields.status] as String?,
    forDate: json[TaskFields.forDate] as String?,
    isCompleted: json[TaskFields.isCompleted] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => {
    TaskFields.id: id,
    TaskFields.jobCardTaskId: jobCardTaskId,
    TaskFields.taskInstruction: taskInstruction,
    TaskFields.description: technicalRemarks,
    TaskFields.taskType: taskType,
    TaskFields.assignedById: assignedById,
    TaskFields.clientId: clientId,
    TaskFields.client: client?.toJson(),
    TaskFields.latitude: latitude,
    TaskFields.longitude: longitude,
    TaskFields.isGeoFenceEnabled: isGeoFenceEnabled,
    TaskFields.maxRadius: maxRadius,
    TaskFields.startDateTime: startDateTime,
    TaskFields.endDateTime: endDateTime,
    TaskFields.status: status,
    TaskFields.forDate: forDate,
    TaskFields.isCompleted: isCompleted,
  };
}
