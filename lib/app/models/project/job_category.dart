class JobCategoryFields {
  static const String jobCategoryId = 'jobCategoryId';
  static const String name = 'name';
  static const String description = 'description';
  static const String colourCode = 'colourCode';

  static const List<String> allFields = <String>[
    jobCategoryId,
    name,
    description,
    colourCode,
  ];
}

class JobCategory{
  final int jobCategoryId;
  final String name;
  final String description;
  final String? colourCode;

  JobCategory({
    required this.jobCategoryId,
    required this.name,
    required this.description,
    this.colourCode,
  });

  factory JobCategory.fromJson(Map<String, dynamic> json) => JobCategory(
        jobCategoryId: (json[JobCategoryFields.jobCategoryId] as num).toInt(),
        name: (json[JobCategoryFields.name] as String).toString(),
        description: (json[JobCategoryFields.description] as String).toString(),
        colourCode: json[JobCategoryFields.colourCode] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        JobCategoryFields.jobCategoryId: jobCategoryId,
        JobCategoryFields.name: name,
        JobCategoryFields.description: description,
        JobCategoryFields.colourCode: colourCode,
      };
}