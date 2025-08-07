class TaskUpdateFields {
  static const String id = 'id';
  static const String comment = 'comment';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String address = 'address';
  static const String fileUrl = 'fileUrl';
  static const String isFromAdmin = 'isFromAdmin';
  static const String taskUpdateType = 'taskUpdateType';
  static const String createdAt = 'createdAt';

  static final List<String> allFields = [
    id,
    comment,
    latitude,
    longitude,
    address,
    fileUrl,
    isFromAdmin,
    taskUpdateType,
    createdAt
  ];
}

class OnClocTaskUpdate {
  final int? id;
  final String? comment;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? fileUrl;
  final bool? isFromAdmin;
  final String? taskUpdateType;
  final String? createdAt;

  OnClocTaskUpdate(
      {this.id,
      this.comment,
      this.latitude,
      this.longitude,
      this.address,
      this.fileUrl,
      this.isFromAdmin,
      this.taskUpdateType,
      this.createdAt});

  factory OnClocTaskUpdate.fromJson(Map<String, dynamic> json) =>
      OnClocTaskUpdate(
        id: json[TaskUpdateFields.id] as int?,
        comment: json[TaskUpdateFields.comment] as String?,
        latitude: (json[TaskUpdateFields.latitude] as num?)?.toDouble(),
        longitude: (json[TaskUpdateFields.longitude] as num?)?.toDouble(),
        address: json[TaskUpdateFields.address] as String?,
        fileUrl: json[TaskUpdateFields.fileUrl] as String?,
        isFromAdmin: json[TaskUpdateFields.isFromAdmin] as bool?,
        taskUpdateType: json[TaskUpdateFields.taskUpdateType] as String?,
        createdAt: json[TaskUpdateFields.createdAt] as String?,
      );
  
  Map<String, dynamic> toJson() => {
        TaskUpdateFields.id: id,
        TaskUpdateFields.comment: comment,
        TaskUpdateFields.latitude: latitude,
        TaskUpdateFields.longitude: longitude,
        TaskUpdateFields.address: address,
        TaskUpdateFields.fileUrl: fileUrl,
        TaskUpdateFields.isFromAdmin: isFromAdmin,
        TaskUpdateFields.taskUpdateType: taskUpdateType,
        TaskUpdateFields.createdAt: createdAt,
      };
}