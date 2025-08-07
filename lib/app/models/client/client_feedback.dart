class ClientFeedbackFields {
  static const String clientFeedbackId = 'clientFeedbackId';
  static const String serviceTicketId = 'serviceTicketId';
  static const String feedbackQuestion = 'feedbackQuestion';
  static const String ratingScore = 'ratingScore';
  static const String comment = 'comment';

  static const List<String> allFields = [
    clientFeedbackId,
    serviceTicketId,
    feedbackQuestion,
    ratingScore,
    comment,
  ];
}

class ClientFeedback {
  final String clientFeedbackId;
  final String serviceTicketId;
  final String feedbackQuestion;
  final double ratingScore;
  final String comment;

  ClientFeedback({
    required this.clientFeedbackId,
    required this.serviceTicketId,
    required this.feedbackQuestion,
    required this.ratingScore,
    required this.comment,
  });

  factory ClientFeedback.fromJson(Map<String, dynamic> json) => ClientFeedback(
      clientFeedbackId: json[ClientFeedbackFields.clientFeedbackId] as String,
      serviceTicketId: json[ClientFeedbackFields.serviceTicketId] as String,
      feedbackQuestion: json[ClientFeedbackFields.feedbackQuestion] as String,
      ratingScore: (json[ClientFeedbackFields.ratingScore] as num).toDouble(),
      comment: json[ClientFeedbackFields.comment] as String,
    );
  
  Map<String, dynamic> toJson() => {
        ClientFeedbackFields.clientFeedbackId: clientFeedbackId,
        ClientFeedbackFields.serviceTicketId: serviceTicketId,
        ClientFeedbackFields.feedbackQuestion: feedbackQuestion,
        ClientFeedbackFields.ratingScore: ratingScore,
        ClientFeedbackFields.comment: comment,
      };
}