class ServiceTicketAttachmentFields {
  static const String serviceTicketAttachmentId = 'serviceTicketAttachmentId';
  static const String serviceTicketId = 'serviceTicketId';
  static const String attachmentTitle = 'attachmentTitle';
  static const String attachmentUrl = 'attachmentUrl';

  static const List<String> allFields = [
    serviceTicketAttachmentId,
    serviceTicketId,
    attachmentTitle,
    attachmentUrl,
  ];
}

class ServiceTicketAttachment {
  final String serviceTicketAttachmentId;
  final String serviceTicketId;
  final String attachmentTitle;
  final String attachmentUrl;

  ServiceTicketAttachment({
    required this.serviceTicketAttachmentId,
    required this.serviceTicketId,
    required this.attachmentTitle,
    required this.attachmentUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      ServiceTicketAttachmentFields.serviceTicketAttachmentId: serviceTicketAttachmentId,
      ServiceTicketAttachmentFields.serviceTicketId: serviceTicketId,
      ServiceTicketAttachmentFields.attachmentTitle: attachmentTitle,
      ServiceTicketAttachmentFields.attachmentUrl: attachmentUrl,
    };
  }

  ServiceTicketAttachment.fromJson(Map<String, dynamic> json)
      : serviceTicketAttachmentId = json[ServiceTicketAttachmentFields.serviceTicketAttachmentId],
        serviceTicketId = json[ServiceTicketAttachmentFields.serviceTicketId],
        attachmentTitle = json[ServiceTicketAttachmentFields.attachmentTitle],
        attachmentUrl = json[ServiceTicketAttachmentFields.attachmentUrl];
}