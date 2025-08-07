const String jobPriorityTable = 'job_priority';

class JobPriorityFields {
  static const String id = 'id';
  static const String jobPriorityLevelId = 'jobPriorityLevelId';
  static const String priorityIndex = 'priorityIndex';
  static const String priorityLevel = 'priorityLevel';
  static const String colourCode = 'colourCode';
  static const String isSynced = 'isSynced';

  static const List<String> values = [
    id,
    jobPriorityLevelId,
    priorityIndex,
    priorityLevel,
    colourCode,
    isSynced,
  ];
}

class JobPriority {
  final int? id;
  final int jobPriorityLevelId;
  final int priorityIndex;
  final String priorityLevel;
  final String colourCode;
  final bool isSynced;

  JobPriority({
    this.id,
    required this.jobPriorityLevelId,
    required this.priorityIndex,
    required this.priorityLevel,
    required this.colourCode,
    required this.isSynced,
  });

  JobPriority copy({
    int? id,
    int? jobPriorityLevelId,
    int? priorityIndex,
    String? priorityLevel,
    String? colourCode,
    bool? isSynced,
  }) => JobPriority(
      id: id ?? this.id,
      jobPriorityLevelId: jobPriorityLevelId ?? this.jobPriorityLevelId,
      priorityIndex: priorityIndex ?? this.priorityIndex,
      priorityLevel: priorityLevel ?? this.priorityLevel,
      colourCode: colourCode ?? this.colourCode,
      isSynced: isSynced ?? this.isSynced ? true : false,
    );

  factory JobPriority.fromJson(Map<String, dynamic> json) => JobPriority(
      id: (json[JobPriorityFields.id] as num).toInt(),
      jobPriorityLevelId: (json[JobPriorityFields.jobPriorityLevelId] as num).toInt(),
      priorityIndex: (json[JobPriorityFields.priorityIndex] as num).toInt(),
      priorityLevel: (json[JobPriorityFields.priorityLevel] as String).toString(),
      colourCode: (json[JobPriorityFields.colourCode] as String).toString(),
      isSynced: (json[JobPriorityFields.isSynced]  == 1) ? true : false,
    );
  
  Map<String, dynamic> toJson() => {
        JobPriorityFields.id: id,
        JobPriorityFields.jobPriorityLevelId: jobPriorityLevelId,
        JobPriorityFields.priorityIndex: priorityIndex,
        JobPriorityFields.priorityLevel: priorityLevel,
        JobPriorityFields.colourCode: colourCode,
        JobPriorityFields.isSynced: isSynced ? 1 : 0,
      };
}