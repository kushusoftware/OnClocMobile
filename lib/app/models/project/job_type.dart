class JobTypeFields {
  static const String jobTypeId = 'jobTypeId';
  static const String name = 'name';
  static const String description = 'description';
  static const String colourCode = 'colourCode';

  static const List<String> allFields = <String>[
    jobTypeId,
    name,
    description,
    colourCode,
  ];
}

class JobType {
  final int jobTypeId;
  final String name;
  final String description;
  final String? colourCode;

  JobType({
    required this.jobTypeId,
    required this.name,
    required this.description,
    this.colourCode,
  });

  factory JobType.fromJson(Map<String, dynamic> json) => JobType(
        jobTypeId: (json[JobTypeFields.jobTypeId] as num).toInt(),
        name: (json[JobTypeFields.name] as String).toString(),
        description: (json[JobTypeFields.description] as String).toString(),
        colourCode: json[JobTypeFields.colourCode] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        JobTypeFields.jobTypeId: jobTypeId,
        JobTypeFields.name: name,
        JobTypeFields.description: description,
        JobTypeFields.colourCode: colourCode,
      };
}