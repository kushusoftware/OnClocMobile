class TicketPriorityFields {
  static const String ticketPriorityId = 'ticketPriorityId';
  static const String priorityIndex = 'priorityIndex';
  static const String priorityLevel = 'priorityLevel';
  static const String colourCode = 'colourCode';

  static List<String> get allFields => [
    ticketPriorityId,
    priorityIndex,
    priorityLevel,
    colourCode,
  ];
}

class TicketPriority {
  final int ticketPriorityId;
  final int priorityIndex;
  final String priorityLevel;
  final String colourCode;

  TicketPriority({
    required this.ticketPriorityId,
    required this.priorityIndex,
    required this.priorityLevel,
    required this.colourCode,
  });

  factory TicketPriority.fromJson(Map<String, dynamic> json) => TicketPriority(
      ticketPriorityId: (json[TicketPriorityFields.ticketPriorityId] as num).toInt(),
      priorityIndex: (json[TicketPriorityFields.priorityIndex] as num).toInt(),
      priorityLevel: json[TicketPriorityFields.priorityLevel] as String,
      colourCode: json[TicketPriorityFields.colourCode] as String,
    );

  Map<String, dynamic> toJson() => {
      TicketPriorityFields.ticketPriorityId: ticketPriorityId,
      TicketPriorityFields.priorityIndex: priorityIndex,
      TicketPriorityFields.priorityLevel: priorityLevel,
      TicketPriorityFields.colourCode: colourCode,
    };
}