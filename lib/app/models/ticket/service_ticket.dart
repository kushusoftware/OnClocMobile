import 'package:on_cloc_mobile/app/models/client/client_feedback.dart';
import 'package:on_cloc_mobile/app/models/client/client_profile.dart';
import 'package:on_cloc_mobile/app/models/project/job_card.dart';
import 'package:on_cloc_mobile/app/models/ticket/ticket_attachment.dart';
import 'package:on_cloc_mobile/app/models/ticket/ticket_task.dart';

const String onClocServiceTicketTable = 'service_ticket';

class ServiceTicketFields {
  static const String id = 'id';
  static const String serviceTicketId = 'serviceTicketId';
  static const String number = 'number';
  static const String subject = 'subject';
  static const String description = 'description';
  static const String remarks = 'remarks';
  static const String ticketStatus = 'ticketStatus';
  static const String ticketPriority = 'ticketPriority';
  static const String ticketCategory = 'ticketCategory';
  static const String openedOnDate = 'openedOnDate';
  static const String dueOnDate = 'dueOnDate';
  static const String closedOnDate = 'closedOnDate';
  static const String canHandleTicket = 'canHandleTicket';
  static const String canCloseTicket = 'canCloseTicket';
  static const String ticketAge = 'ticketAge';
  static const String ticketRating = 'ticketRating';
  static const String tasksList = 'tasksList';
  static const String attachmentsList = 'attachmentsList';
  static const String jobCardsList = 'jobCardsList';
  static const String clientsList = 'clientsList';
  static const String feedbackList = 'feedbackList';

  static final List<String> values = [
    id,
    serviceTicketId,
    number,
    subject,
    description,
    remarks,
    ticketStatus,
    ticketPriority,
    ticketCategory,
    openedOnDate,
    dueOnDate,
    closedOnDate,
    canHandleTicket,
    canCloseTicket,
    ticketAge,
    ticketRating,
    tasksList,
    attachmentsList,
    jobCardsList,
    clientsList,
    feedbackList
  ];
}

class ServiceTicket {
  final int? id;
  final String serviceTicketId;
  final String number;
  final String subject;
  final String description;
  final String? remarks;
  final String? ticketStatus;
  final String? ticketPriority;
  final String? ticketCategory;
  final DateTime openedOnDate;
  final DateTime dueOnDate;
  final DateTime? closedOnDate;
  final bool canHandleTicket;
  final bool canCloseTicket;
  final double ticketAge;
  final double? ticketRating;
  final List<TicketTask> tasksList;
  final List<ServiceTicketAttachment> attachmentsList;
  final List<JobCard> jobCardsList;
  final List<ClientProfile> clientsList;
  final List<ClientFeedback> feedbackList;

  ServiceTicket({
    this.id,
    required this.serviceTicketId,
    required this.number,
    required this.subject,
    required this.description,
    this.remarks,
    this.ticketStatus,
    this.ticketPriority,
    this.ticketCategory,
    required this.openedOnDate,
    required this.dueOnDate,
    this.closedOnDate,
    required this.canHandleTicket,
    required this.canCloseTicket,
    required this.ticketAge,
    this.ticketRating,
    required this.tasksList,
    required this.attachmentsList,
    required this.jobCardsList,
    required this.clientsList,
    required this.feedbackList,
  });

  factory ServiceTicket.fromJson(Map<String, dynamic> json) => ServiceTicket(
      id: json[ServiceTicketFields.id] as int?,
      serviceTicketId: json[ServiceTicketFields.serviceTicketId] as String,
      number: json[ServiceTicketFields.number] as String,
      subject: json[ServiceTicketFields.subject] as String,
      description: json[ServiceTicketFields.description] as String,
      remarks: json[ServiceTicketFields.remarks] as String?,
      ticketStatus: json[ServiceTicketFields.ticketStatus] as String?,
      ticketPriority: json[ServiceTicketFields.ticketPriority] as String?,
      ticketCategory: json[ServiceTicketFields.ticketCategory] as String?,
      openedOnDate: DateTime.parse(json[ServiceTicketFields.openedOnDate]),
      dueOnDate: DateTime.parse(json[ServiceTicketFields.dueOnDate]),
      closedOnDate: json[ServiceTicketFields.closedOnDate] != null
          ? DateTime.parse(json[ServiceTicketFields.closedOnDate])
          : null,
      canHandleTicket:
          json[ServiceTicketFields.canHandleTicket] == 1 ? true : false,
      canCloseTicket:
          json[ServiceTicketFields.canCloseTicket] == 1 ? true : false,
      ticketAge: (json[ServiceTicketFields.ticketAge] as num).toDouble(),
      ticketRating:
          (json[ServiceTicketFields.ticketRating] as num?)?.toDouble(),
      tasksList: (json[ServiceTicketFields.tasksList] as List)
          .map((task) => TicketTask.fromJson(task))
          .toList(),
      attachmentsList: (json[ServiceTicketFields.attachmentsList] as List)
          .map((attachment) => ServiceTicketAttachment.fromJson(attachment))
          .toList(),
      jobCardsList: (json[ServiceTicketFields.jobCardsList] as List)
          .map((jobCard) => JobCard.fromJson(jobCard))
          .toList(),
      clientsList: (json[ServiceTicketFields.clientsList] as List)
          .map((client) => ClientProfile.fromJson(client))
          .toList(),
      feedbackList: (json[ServiceTicketFields.feedbackList] as List)
          .map((feedback) => ClientFeedback.fromJson(feedback))
          .toList(),
    );

  Map<String, dynamic> toJson() => {
        ServiceTicketFields.id: id,
        ServiceTicketFields.serviceTicketId: serviceTicketId,
        ServiceTicketFields.number: number,
        ServiceTicketFields.subject: subject,
        ServiceTicketFields.description: description,
        ServiceTicketFields.remarks: remarks,
        ServiceTicketFields.ticketStatus: ticketStatus,
        ServiceTicketFields.ticketPriority: ticketPriority,
        ServiceTicketFields.ticketCategory: ticketCategory,
        ServiceTicketFields.openedOnDate: openedOnDate.toIso8601String(),
        ServiceTicketFields.dueOnDate: dueOnDate.toIso8601String(),
        ServiceTicketFields.closedOnDate:
            closedOnDate?.toIso8601String(),
        ServiceTicketFields.canHandleTicket:
            canHandleTicket ? 1 : 0,
        ServiceTicketFields.canCloseTicket:
            canCloseTicket ? 1 : 0,
        ServiceTicketFields.ticketAge: ticketAge,
        ServiceTicketFields.ticketRating: ticketRating,
        ServiceTicketFields.tasksList:
            tasksList.map((task) => task.toJson()).toList(),
        ServiceTicketFields.attachmentsList:
            attachmentsList.map((attachment) => attachment.toJson()).toList(),
        ServiceTicketFields.jobCardsList:
            jobCardsList.map((jobCard) => jobCard.toJson()).toList(),
        ServiceTicketFields.clientsList:
            clientsList.map((client) => client.toJson()).toList(),
        ServiceTicketFields.feedbackList:
            feedbackList.map((feedback) => feedback.toJson()).toList(),
      };
}
