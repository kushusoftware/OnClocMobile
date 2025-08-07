class TicketTaskStepFields {
  static const String ticketTaskStepId = 'ticketTaskStepId';
  static const String stepsTaken = 'stepsTaken';
  static const String stepRemarks = 'stepRemarks';

  static const List<String> allFields = [
    ticketTaskStepId,
    stepsTaken,
    stepRemarks,
  ];
}

class TicketTaskStep {
  final String ticketTaskStepId;
  final String stepsTaken;
  final String stepRemarks;

  TicketTaskStep({
    required this.ticketTaskStepId,
    required this.stepsTaken,
    required this.stepRemarks,
  });

  factory TicketTaskStep.fromJson(Map<String, dynamic> json) => TicketTaskStep(
      ticketTaskStepId: json[TicketTaskStepFields.ticketTaskStepId] as String,
      stepsTaken: json[TicketTaskStepFields.stepsTaken] as String,
      stepRemarks: json[TicketTaskStepFields.stepRemarks] as String,
    );

  Map<String, dynamic> toJson() => {
      TicketTaskStepFields.ticketTaskStepId: ticketTaskStepId,
      TicketTaskStepFields.stepsTaken: stepsTaken,
      TicketTaskStepFields.stepRemarks: stepRemarks,
    };
}