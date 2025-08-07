const String travelItineraryTable = 'travel_itinerary';

class TravelItineraryFields {
  static const String id = 'id';
  static const String travelId = 'travel_id';
  static const String travelDate = 'travel_date';
  static const String travelFrom = 'travel_from';
  static const String travelTo = 'travel_to';
  static const String travelMode = 'travel_mode';
  static const String travelStatus = 'travel_status';
  static const String eventName = 'event_name';
  static const String eventDescription = 'event_description';

  static const List<String> allFields = [
    id,
    travelId,
    travelDate,
    travelFrom,
    travelTo,
    travelMode,
    travelStatus,
    eventName,
    eventDescription
  ];
}

class OnClocTravelItinerary{
  final int id;
  final String travelId;
  final DateTime travelDate;
  final String travelFrom;
  final String travelTo;
  final String? travelMode;
  final String travelStatus;
  final String eventName;
  final String? eventDescription;

  const OnClocTravelItinerary({
    required this.id,
    required this.travelId,
    required this.travelDate,
    required this.travelFrom,
    required this.travelTo,
    this.travelMode,
    required this.travelStatus,
    required this.eventName,
    this.eventDescription,
  });

  factory OnClocTravelItinerary.fromJson(Map<String, dynamic> json) => OnClocTravelItinerary(
    id: json[TravelItineraryFields.id] as int,
    travelId: json[TravelItineraryFields.travelId] as String,
    travelDate: DateTime.parse(json[TravelItineraryFields.travelDate].toString()),
    travelFrom: json[TravelItineraryFields.travelFrom] as String,
    travelTo: json[TravelItineraryFields.travelTo] as String,
    travelMode: json[TravelItineraryFields.travelMode] as String?,
    travelStatus: json[TravelItineraryFields.travelStatus] as String,
    eventName: json[TravelItineraryFields.eventName] as String,
    eventDescription: json[TravelItineraryFields.eventDescription] as String?,
  );

  Map<String, dynamic> toJson() => {
    TravelItineraryFields.id: id,
    TravelItineraryFields.travelId: travelId,
    TravelItineraryFields.travelDate: travelDate.toIso8601String(),
    TravelItineraryFields.travelFrom: travelFrom,
    TravelItineraryFields.travelTo: travelTo,
    TravelItineraryFields.travelMode: travelMode,
    TravelItineraryFields.travelStatus: travelStatus,
    TravelItineraryFields.eventName: eventName,
    TravelItineraryFields.eventDescription: eventDescription,
  };
}