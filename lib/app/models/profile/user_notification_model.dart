const String userNotificationTable = 'user_notification';

class UserNotificationFields{
  static final String id = 'id';
  static final String title = 'title';
  static final String message = 'message';
  static final String dateTime = 'date_time';
  static final String notificationType = 'notification_type';
  static final String imageUrl = 'image_url';

  static final List<String> allFields = [
    id,
    title,
    message,
    dateTime,
    notificationType,
    imageUrl,
  ];
}

class OnClocUserNotification {
  final int id;
  final String title;
  final String message;
  final String dateTime;
  final String notificationType;
  final String? imageUrl;

  OnClocUserNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.dateTime,
    required this.notificationType,
    this.imageUrl,
  });

  factory OnClocUserNotification.fromJson(Map<String, dynamic> json) => OnClocUserNotification(
      id: json[UserNotificationFields.id],
      title: json[UserNotificationFields.title] as String,
      message: json[UserNotificationFields.message] as String,
      dateTime: json[UserNotificationFields.dateTime] as String,
      notificationType: json[UserNotificationFields.notificationType] as String,
      imageUrl: json[UserNotificationFields.imageUrl] as String?,
    );

  Map<String, dynamic> toJson() => {
      UserNotificationFields.id: id,
      UserNotificationFields.title: title,
      UserNotificationFields.message: message,
      UserNotificationFields.dateTime: dateTime,
      UserNotificationFields.notificationType: notificationType,
      UserNotificationFields.imageUrl: imageUrl,
    };
  
}