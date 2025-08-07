class TicketCategoryFields {
  static const String ticketCategoryId = 'ticketCategoryId';
  static const String name = 'name';
  static const String description = 'description';
  static const String colourCode = 'colourCode';

  static List<String> get allFields => [
    ticketCategoryId,
    name,
    description,
    colourCode,
  ];
}

class TicketCategory {
  final int ticketCategoryId;
  final String name;
  final String description;
  final String colourCode;

  TicketCategory({
    required this.ticketCategoryId,
    required this.name,
    required this.description,
    required this.colourCode,
  });

  factory TicketCategory.fromJson(Map<String, dynamic> json) => TicketCategory(
      ticketCategoryId: (json[TicketCategoryFields.ticketCategoryId] as num).toInt(),
      name: json[TicketCategoryFields.name] as String,
      description: json[TicketCategoryFields.description] as String,
      colourCode: json[TicketCategoryFields.colourCode] as String,
    );

  Map<String, dynamic> toJson() => {
      TicketCategoryFields.ticketCategoryId: ticketCategoryId,
      TicketCategoryFields.name: name,
      TicketCategoryFields.description: description,
      TicketCategoryFields.colourCode: colourCode,
    };
}