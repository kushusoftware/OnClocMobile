import 'package:on_cloc_mobile/app/models/ticket/ticket_task_step.dart';

class TicketTaskFields {
  static const String serviceTicketTaskId = 'serviceTicketTaskId';
  static const String serviceTicketId = 'serviceTicketId';
  static const String taskInstructions = 'taskInstructions';
  static const String technicalRemarks = 'technicalRemarks';
  static const String dueDate = 'dueDate';
  static const String taskStarted = 'taskStarted';
  static const String taskCompleted = 'taskCompleted';
  static const String taskDuration = 'taskDuration';
  static const String isCompleted = 'isCompleted';
  static const String taskSteps = 'taskSteps';

  static const List<String> allFields = [
    serviceTicketTaskId,
    serviceTicketId,
    taskInstructions,
    technicalRemarks,
    dueDate,
    taskStarted,
    taskCompleted,
    taskDuration,
    isCompleted,
    taskSteps,
  ];
}

class TicketTask {
  final String serviceTicketTaskId;
  final String serviceTicketId;
  final String taskInstructions;
  final String? technicalRemarks;
  final DateTime dueDate;
  final DateTime? taskStarted;
  final DateTime? taskCompleted;
  final double taskDuration;
  final bool isCompleted;
  final List<TicketTaskStep> taskSteps;

  TicketTask({
    required this.serviceTicketTaskId,
    required this.serviceTicketId,
    required this.taskInstructions,
    this.technicalRemarks,
    required this.dueDate,
    this.taskStarted,
    this.taskCompleted,
    required this.taskDuration,
    required this.isCompleted,
    this.taskSteps = const [],
  });

  factory TicketTask.fromJson(Map<String, dynamic> json) => TicketTask(
      serviceTicketTaskId: json[TicketTaskFields.serviceTicketTaskId] as String,
      serviceTicketId: json[TicketTaskFields.serviceTicketId] as String,
      taskInstructions: json[TicketTaskFields.taskInstructions] as String,
      technicalRemarks: json[TicketTaskFields.technicalRemarks] as String?,
      dueDate: DateTime.parse(json[TicketTaskFields.dueDate] as String),
      taskStarted: json[TicketTaskFields.taskStarted] != null
          ? DateTime.parse(json[TicketTaskFields.taskStarted] as String)
          : null,
      taskCompleted: json[TicketTaskFields.taskCompleted] != null
          ? DateTime.parse(json[TicketTaskFields.taskCompleted] as String)
          : null,
      taskDuration: (json[TicketTaskFields.taskDuration] as num).toDouble(),
      isCompleted: json[TicketTaskFields.isCompleted] as bool,
      taskSteps: (json[TicketTaskFields.taskSteps] as List<dynamic>)
          .map((step) => TicketTaskStep.fromJson(step as Map<String, dynamic>))
          .toList(),
    );

  Map<String, dynamic> toJson() => {
        TicketTaskFields.serviceTicketTaskId: serviceTicketTaskId,
        TicketTaskFields.serviceTicketId: serviceTicketId,
        TicketTaskFields.taskInstructions: taskInstructions,
        TicketTaskFields.technicalRemarks: technicalRemarks,
        TicketTaskFields.dueDate: dueDate.toIso8601String(),
        TicketTaskFields.taskStarted:
            taskStarted?.toIso8601String(),
        TicketTaskFields.taskCompleted:
            taskCompleted?.toIso8601String(),
        TicketTaskFields.taskDuration: taskDuration,
        TicketTaskFields.isCompleted: isCompleted,
        TicketTaskFields.taskSteps: taskSteps.map((step) => step.toJson()).toList(),
      };
}