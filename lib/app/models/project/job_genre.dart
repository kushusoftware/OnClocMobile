class JobGenreFields {
  static const String jobGenreId = 'jobGenreId';
  static const String name = 'name';
  static const String description = 'description';
  static const String colourCode = 'colourCode';

  static const List<String> allFields = <String>[
    jobGenreId,
    name,
    description,
    colourCode,
  ];
}

class JobGenre {
  final int jobGenreId;
  final String name;
  final String description;
  final String? colourCode;

  JobGenre({
    required this.jobGenreId,
    required this.name,
    required this.description,
    this.colourCode,
  });

  factory JobGenre.fromJson(Map<String, dynamic> json) => JobGenre(
        jobGenreId: (json[JobGenreFields.jobGenreId] as num).toInt(),
        name: (json[JobGenreFields.name] as String).toString(),
        description: (json[JobGenreFields.description] as String).toString(),
        colourCode: json[JobGenreFields.colourCode] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        JobGenreFields.jobGenreId: jobGenreId,
        JobGenreFields.name: name,
        JobGenreFields.description: description,
        JobGenreFields.colourCode: colourCode,
      };
}