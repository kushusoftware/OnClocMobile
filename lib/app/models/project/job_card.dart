import 'package:on_cloc_mobile/app/models/client/client_profile.dart';

const String jobCardTable = 'job_card';

class JobCardFields {
  static final String id = 'id';
  static final String jobCardId = 'jobCardId';
  static final String serviceTicketId = 'serviceTicketId';
  static final String serviceProjectId = 'serviceProjectId';
  static final String status = 'status';
  static final String priorityLevel = 'priorityLevel';
  static final String jobType = 'jobType';
  static final String jobCategory = 'jobCategory';
  static final String jobClass = 'jobClass';
  static final String jobGroup = 'jobGroup';
  static final String jobGenre = 'jobGenre';
  static final String contactNumber = 'contactNumber';
  static final String subject = 'subject';
  static final String description = 'description';
  static final String location = 'location';
  static final String scheduledDate = 'scheduledDate';
  static final String startDate = 'startDate';
  static final String endDate = 'endDate';
  static final String estimatedDuration = 'estimatedDuration';
  static final String actualDuration = 'actualDuration';
  static final String canHandleJobCard = 'canHandleJobCard';
  static final String canCloseJobCard = 'canCloseJobCard';
  static final String clientProfiles = 'clientProfiles';

  static final List<String> allFields = [
    id,
    jobCardId,
    serviceTicketId,
    serviceProjectId,
    status,
    priorityLevel,
    jobType,
    jobCategory,
    jobClass,
    jobGroup,
    jobGenre,
    contactNumber,
    subject,
    description,
    location,
    scheduledDate,
    startDate,
    endDate,
    estimatedDuration,
    actualDuration,
    canHandleJobCard,
    canCloseJobCard,
    clientProfiles
  ];
}

class JobCard {
  final int? id;
  final String jobCardId;
  final String serviceTicketId;
  final String serviceProjectId;
  final String status;
  final String priorityLevel;
  final String jobType;
  final String jobCategory;
  final String jobClass;
  final String jobGroup;
  final String jobGenre;
  final String contactNumber;
  final String subject;
  final String? description;
  final String? location;
  final String scheduledDate;
  final String? startDate;
  final String? endDate;
  final double estimatedDuration;
  final double? actualDuration;
  final bool canHandleJobCard;
  final bool canCloseJobCard;
  final List<ClientProfile> clientProfiles;

  JobCard({
    this.id,
    required this.jobCardId,
    required this.serviceTicketId,
    required this.serviceProjectId,
    required this.status,
    required this.priorityLevel,
    required this.jobType,
    required this.jobCategory,
    required this.jobClass,
    required this.jobGroup,
    required this.jobGenre,
    required this.contactNumber,
    required this.subject,
    this.description,
    this.location,
    required this.scheduledDate,
    this.startDate,
    this.endDate,
    required this.estimatedDuration,
    this.actualDuration,
    required this.canHandleJobCard,
    required this.canCloseJobCard,
    this.clientProfiles = const [],
  });

  factory JobCard.fromJson(Map<String, dynamic> json) => JobCard(
      id: json[JobCardFields.id] as int?,
      jobCardId: json[JobCardFields.jobCardId] as String,
      serviceTicketId: json[JobCardFields.serviceTicketId] as String,
      serviceProjectId: json[JobCardFields.serviceProjectId] as String,
      status: json[JobCardFields.status] as String,
      priorityLevel: json[JobCardFields.priorityLevel] as String,
      jobType: json[JobCardFields.jobType] as String,
      jobCategory: json[JobCardFields.jobCategory] as String,
      jobClass: json[JobCardFields.jobClass] as String,
      jobGroup: json[JobCardFields.jobGroup] as String,
      jobGenre: json[JobCardFields.jobGenre] as String,
      contactNumber: json[JobCardFields.contactNumber] as String,
      subject: json[JobCardFields.subject] as String,
      description: json[JobCardFields.description] as String?,
      location: json[JobCardFields.location] as String?,
      scheduledDate: json[JobCardFields.scheduledDate] as String,
      startDate: json[JobCardFields.startDate] as String?,
      endDate: json[JobCardFields.endDate] as String?,
      estimatedDuration: (json[JobCardFields.estimatedDuration] as num).toDouble(),
      actualDuration: (json[JobCardFields.actualDuration] as num?)?.toDouble(),
      canHandleJobCard:
          (json[JobCardFields.canHandleJobCard] as bool?) ?? false,
      canCloseJobCard:
          (json[JobCardFields.canCloseJobCard] as bool?) ?? false,
      clientProfiles: (json[JobCardFields.clientProfiles] as List<dynamic>?)
              ?.map((e) => ClientProfile.fromJson(e))
              .toList() ?? [],
    );

  Map<String, dynamic> toJson() => {
        JobCardFields.id: id,
        JobCardFields.jobCardId: jobCardId,
        JobCardFields.serviceTicketId: serviceTicketId,
        JobCardFields.serviceProjectId: serviceProjectId,
        JobCardFields.status: status,
        JobCardFields.priorityLevel: priorityLevel,
        JobCardFields.jobType: jobType,
        JobCardFields.jobCategory: jobCategory,
        JobCardFields.jobClass: jobClass,
        JobCardFields.jobGroup: jobGroup,
        JobCardFields.jobGenre: jobGenre,
        JobCardFields.contactNumber: contactNumber,
        JobCardFields.subject: subject,
        JobCardFields.description: description,
        JobCardFields.location: location,
        JobCardFields.scheduledDate: scheduledDate,
        JobCardFields.startDate: startDate,
        JobCardFields.endDate: endDate, 
        JobCardFields.estimatedDuration: estimatedDuration,
        JobCardFields.actualDuration: actualDuration,
        JobCardFields.canHandleJobCard: canHandleJobCard,
        JobCardFields.canCloseJobCard: canCloseJobCard,
        JobCardFields.clientProfiles: clientProfiles.map((e) => e.toJson()).toList(),
  };
}