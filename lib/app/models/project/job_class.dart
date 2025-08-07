class JobClassFields {
  static const String jobClassId = 'jobClassId';
  static const String name = 'name';
  static const String description = 'description';
  static const String colourCode = 'colourCode';

  static const  List<String> allFields = <String>[
    jobClassId,
    name,
    description,
    colourCode,
  ];
}

class JobClass {
  final int jobClassId;
  final String name;
  final String description;
  final String? colourCode;

  JobClass({
    required this.jobClassId,
    required this.name,
    required this.description,
    this.colourCode,
  });

  factory JobClass.fromJson(Map<String, dynamic> json) => JobClass(
        jobClassId: (json[JobClassFields.jobClassId] as num).toInt(),
        name: (json[JobClassFields.name] as String).toString(),
        description: (json[JobClassFields.description] as String).toString(),
        colourCode: json[JobClassFields.colourCode] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        JobClassFields.jobClassId: jobClassId,
        JobClassFields.name: name,
        JobClassFields.description: description,
        JobClassFields.colourCode: colourCode,
      };
}