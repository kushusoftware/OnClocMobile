import 'package:nb_utils/nb_utils.dart';

class JobStatusFields{
  static const String jobStatusId = 'jobStatusId';
  static const String status = 'status';
  static const String colourCode = 'colourCode';

  static const List<String> values = [
    jobStatusId,
    status,
    colourCode,
  ];
}

class JobStatus {
  final int jobStatusId;
  final String status;
  final String colourCode;

  const JobStatus({
    required this.jobStatusId,
    required this.status,
    required this.colourCode,
  });

  factory JobStatus.fromJson(Map<String, dynamic> json) {
    return JobStatus(
      jobStatusId: (json[JobStatusFields.jobStatusId] as String).toInt(),
      status: (json[JobStatusFields.status] as String).toString(),
      colourCode: (json[JobStatusFields.colourCode] as String).toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      JobStatusFields.jobStatusId: jobStatusId,
      JobStatusFields.status: status,
      JobStatusFields.colourCode: colourCode,
    };
  }
}