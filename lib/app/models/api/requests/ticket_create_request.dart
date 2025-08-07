class CreateTicketRequestFields {
  static const String subject = 'subject';
  static const String description = 'description';
  static const String taskInstruction = 'taskInstruction';
  static const String taskDueDateTime = 'taskDueDateTime';
  static const String ticketCategoryId = 'ticketCategoryId';
  static const String ticketPriorityId = 'ticketPriorityId';
  static const String clientProfileId = 'clientProfileId';
  static const String serviceOfficerProfileId = 'serviceOfficerProfileId';

  static const List<String> allFields = [
    subject,
    description,
    taskInstruction,
    taskDueDateTime,
    ticketCategoryId,
    ticketPriorityId,
    clientProfileId,
    serviceOfficerProfileId,
  ];
}

class CreateTicketRequest {
  final String subject;
  final String description;
  final String taskInstruction;
  final DateTime taskDueDateTime;
  final int ticketCategoryId;
  final int ticketPriorityId;
  final String clientProfileId;
  final String serviceOfficerProfileId;

  CreateTicketRequest({
    required this.subject,
    required this.description,
    required this.taskInstruction,
    required this.taskDueDateTime,
    required this.ticketCategoryId,
    required this.ticketPriorityId,
    required this.clientProfileId,
    required this.serviceOfficerProfileId,
  });

  factory CreateTicketRequest.fromJson(Map<String, dynamic> json) => CreateTicketRequest(
        subject: (json[CreateTicketRequestFields.subject] as String).toString(),
        description: (json[CreateTicketRequestFields.description] as String).toString(),
        taskInstruction: (json[CreateTicketRequestFields.taskInstruction] as String).toString(),
        taskDueDateTime: DateTime.parse(json[CreateTicketRequestFields.taskDueDateTime] as String),
        ticketCategoryId: (json[CreateTicketRequestFields.ticketCategoryId] as int?) ?? 0,
        ticketPriorityId: (json[CreateTicketRequestFields.ticketPriorityId] as int?) ?? 0,
        clientProfileId: (json[CreateTicketRequestFields.clientProfileId] as String).toString(),
        serviceOfficerProfileId: (json[CreateTicketRequestFields.serviceOfficerProfileId] as String).toString(),
      );

  Map<String, dynamic> toJson() => {
        CreateTicketRequestFields.subject: subject,
        CreateTicketRequestFields.description: description,
        CreateTicketRequestFields.taskInstruction: taskInstruction,
        CreateTicketRequestFields.taskDueDateTime: taskDueDateTime.toIso8601String(),
        CreateTicketRequestFields.ticketCategoryId: ticketCategoryId,
        CreateTicketRequestFields.ticketPriorityId: ticketPriorityId,
        CreateTicketRequestFields.clientProfileId: clientProfileId,
        CreateTicketRequestFields.serviceOfficerProfileId: serviceOfficerProfileId,
      };
}