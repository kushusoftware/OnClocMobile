const String jobCardAllocationTable = 'job_card_allocation';

class JobAllocationFields {
  static const String serviceDeskId = 'serviceDeskId';
  static const String jobCardAllocationId = 'jobCardAllocationId';
  static const String jobCardId = 'jobCardId';
  static const String serviceTicketId = 'serviceTicketId';
  static const String isPrimaryTechnician = 'isPrimaryTechnician';
  static const String clientName = 'clientName';
  static const String clientAvatorUrl = 'clientAvatorUrl';
  static const String projectName = 'projectName';
  static const String jobStatus = 'jobStatus';
  static const String priorityLevel = 'priorityLevel';
  static const String jobType = 'jobType';
  static const String jobCategory = 'jobCategory';
  static const String jobClass = 'jobClass';
  static const String jobGroup = 'jobGroup';
  static const String jobGenre = 'jobGenre';
  static const String subject = 'subject';
  static const String description = 'description';
  static const String location = 'location';
  static const String contactNumber = 'contactNumber';
  static const String assignedDate = 'assignedDate';
  static const String dueDate = 'dueDate';
  static const String scheduledDate = 'scheduledDate';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';
  static const String estimatedDuration = 'estimatedDuration';
  static const String actualDuration = 'actualDuration';
  static const String approvedBy = 'approvedBy';
  static const String allowReOpen = 'allowReOpen';
  static const String isJobRunning = 'isJobRunning';

static const List<String> allFields = [
    serviceDeskId,
    jobCardAllocationId,
    jobCardId,
    serviceTicketId,
    isPrimaryTechnician,
    clientName,
    clientAvatorUrl,
    projectName,
    jobStatus,
    priorityLevel,
    jobType,
    jobCategory,
    jobClass,
    jobGroup,
    jobGenre,
    subject,
    description,
    location,
    contactNumber,
    assignedDate,
    dueDate,
    scheduledDate,
    startDate,
    endDate,
    estimatedDuration,
    actualDuration,
    approvedBy,
    allowReOpen,
    isJobRunning
  ];
}

class JobAllocation {
  final int serviceDeskId;
  final String jobCardAllocationId;
  final String jobCardId;
  final String serviceTicketId;
  final bool isPrimaryTechnician;
  final String clientName;
  final String clientAvatorUrl;
  final String projectName;
  final String jobStatus;
  final String priorityLevel;
  final String jobType;
  final String jobCategory;
  final String jobClass;
  final String jobGroup;
  final String jobGenre;
  final String subject;
  final String? description;
  final String? location;
  final String contactNumber;
  final DateTime assignedDate;
  final DateTime dueDate;
  final DateTime scheduledDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final double? estimatedDuration;
  final double? actualDuration;
  final String approvedBy;
  final bool allowReOpen;
  final bool isJobRunning;

  JobAllocation({
    required this.serviceDeskId,
    required this.jobCardAllocationId,
    required this.jobCardId,
    required this.serviceTicketId,
    required this.isPrimaryTechnician,
    required this.clientName,
    required this.clientAvatorUrl,
    required this.projectName,
    required this.jobStatus,
    required this.priorityLevel,
    required this.jobType,
    required this.jobCategory,
    required this.jobClass,
    required this.jobGroup,
    required this.jobGenre,
    required this.subject,
    this.description,
    this.location,
    required this.contactNumber,
    required this.assignedDate,
    required this.dueDate,
    required this.scheduledDate,
    this.startDate,
    this.endDate,
    this.estimatedDuration,
    this.actualDuration,
    required this.approvedBy,
    required this.allowReOpen,
    required this.isJobRunning
  });

  factory JobAllocation.fromJson(Map<String, dynamic> json) => JobAllocation(
        serviceDeskId: (json[JobAllocationFields.serviceDeskId] as num).toInt(),
        jobCardAllocationId: (json[JobAllocationFields.jobCardAllocationId] as String).toString(),
        jobCardId: (json[JobAllocationFields.jobCardId] as String).toString(),
        serviceTicketId: (json[JobAllocationFields.serviceTicketId] as String).toString(),
        isPrimaryTechnician: json[JobAllocationFields.isPrimaryTechnician] == 1 ? true : false,
        clientName: (json[JobAllocationFields.clientName] as String).toString(),
        clientAvatorUrl: (json[JobAllocationFields.clientAvatorUrl] as String).toString(),
        projectName: (json[JobAllocationFields.projectName] as String).toString(),
        jobStatus: (json[JobAllocationFields.jobStatus] as String).toString(),
        priorityLevel: (json[JobAllocationFields.priorityLevel] as String).toString(),
        jobType: (json[JobAllocationFields.jobType] as String).toString(),
        jobCategory: (json[JobAllocationFields.jobCategory] as String).toString(),
        jobClass: (json[JobAllocationFields.jobClass] as String).toString(),
        jobGroup: (json[JobAllocationFields.jobGroup] as String).toString(),
        jobGenre: (json[JobAllocationFields.jobGenre] as String).toString(),
        subject: (json[JobAllocationFields.subject] as String).toString(),
        description: json[JobAllocationFields.description]?.toString() ?? '',
        location: json[JobAllocationFields.location]?.toString() ?? '',
        contactNumber: (json[JobAllocationFields.contactNumber] as String).toString(),
        assignedDate: DateTime.parse(json[JobAllocationFields.assignedDate] as String),
        dueDate: DateTime.parse(json[JobAllocationFields.dueDate] as String),
        scheduledDate: DateTime.parse(json[JobAllocationFields.scheduledDate] as String),
        startDate: json[JobAllocationFields.startDate]?.isEmpty == true ? null : DateTime.parse(json[JobAllocationFields.startDate]),
        endDate: json[JobAllocationFields.endDate]?.isEmpty == true ? null : DateTime.parse(json[JobAllocationFields.endDate]),
        estimatedDuration: json[JobAllocationFields.estimatedDuration] == null ? null : (json[JobAllocationFields.estimatedDuration] as num).toDouble(),
        actualDuration: json[JobAllocationFields.actualDuration] == null ? null : (json[JobAllocationFields.actualDuration] as num).toDouble(),
        approvedBy: (json[JobAllocationFields.approvedBy] as String).toString(),
        allowReOpen: json[JobAllocationFields.allowReOpen] as bool,
        isJobRunning: json[JobAllocationFields.isJobRunning] as bool,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        JobAllocationFields.serviceDeskId: serviceDeskId,
        JobAllocationFields.jobCardAllocationId: jobCardAllocationId,
        JobAllocationFields.jobCardId: jobCardId,
        JobAllocationFields.serviceTicketId: serviceTicketId,
        JobAllocationFields.isPrimaryTechnician: isPrimaryTechnician ? 1 : 0,
        JobAllocationFields.clientName: clientName,
        JobAllocationFields.clientAvatorUrl: clientAvatorUrl,
        JobAllocationFields.projectName: projectName,
        JobAllocationFields.jobStatus: jobStatus,
        JobAllocationFields.priorityLevel: priorityLevel,
        JobAllocationFields.jobType: jobType,
        JobAllocationFields.jobCategory: jobCategory,
        JobAllocationFields.jobClass: jobClass,
        JobAllocationFields.jobGroup: jobGroup,
        JobAllocationFields.jobGenre: jobGenre,
        JobAllocationFields.subject: subject,
        JobAllocationFields.description: description,
        JobAllocationFields.location: location,
        JobAllocationFields.contactNumber: contactNumber,
        JobAllocationFields.assignedDate: assignedDate.toIso8601String(),
        JobAllocationFields.dueDate: dueDate.toIso8601String(),
        JobAllocationFields.scheduledDate: scheduledDate.toIso8601String(),
        JobAllocationFields.startDate: startDate?.toIso8601String(),
        JobAllocationFields.endDate: endDate?.toIso8601String(),
        JobAllocationFields.estimatedDuration: estimatedDuration,
        JobAllocationFields.actualDuration: actualDuration,
        JobAllocationFields.approvedBy: approvedBy,
        JobAllocationFields.allowReOpen: allowReOpen ? 1 : 0,
        JobAllocationFields.isJobRunning: isJobRunning ? 1 : 0
      };
}