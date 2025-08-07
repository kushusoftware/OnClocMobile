class JobGroupFields {
  static const String jobGroupId = 'jobGroupId';
  static const String name = 'name'; 
  static const String description = 'description';
  static const String colourCode = 'colourCode';

  static const List<String> allFields = <String>[
    jobGroupId,
    name,
    description,
    colourCode,
  ];
}

class JobGroup {
  final int jobGroupId;
  final String name;
  final String description;
  final String? colourCode;

  JobGroup({
    required this.jobGroupId,
    required this.name,
    required this.description,
    this.colourCode,
  });

  factory JobGroup.fromJson(Map<String, dynamic> json) => JobGroup(
        jobGroupId: (json[JobGroupFields.jobGroupId] as num).toInt(),
        name: (json[JobGroupFields.name] as String).toString(),
        description: (json[JobGroupFields.description] as String).toString(),
        colourCode: json[JobGroupFields.colourCode] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        JobGroupFields.jobGroupId: jobGroupId,
        JobGroupFields.name: name,
        JobGroupFields.description: description,
        JobGroupFields.colourCode: colourCode,
      };
}