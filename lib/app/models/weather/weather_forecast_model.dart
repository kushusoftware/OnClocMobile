class WeatherForecastFields {
  static const String date = 'date';
  static const String temperatureC = 'temperatureC';
  static const String temperatureF = 'temperatureF';
  static const String summary = 'summary';

  static const List<String> allFields = [
    date,
    temperatureC,
    temperatureF,
    summary
  ];
}

class WeatherForecast {
  final DateTime date;
  final int temperatureC;
  final int temperatureF;
  final String? summary;

  WeatherForecast({
    required this.date,
    required this.temperatureC,
    required this.temperatureF,
    this.summary
   });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) => 
    WeatherForecast(
      date: DateTime.parse(json[WeatherForecastFields.date] as String), 
      temperatureC: (json[WeatherForecastFields.temperatureC] as num).toInt(), 
      temperatureF: (json[WeatherForecastFields.temperatureF] as num).toInt(),
      summary: (json[WeatherForecastFields.summary] as String?).toString(),
    );

  Map<String, dynamic> toJson() => 
    {
      WeatherForecastFields.date: date..toIso8601String(), 
      WeatherForecastFields.temperatureC: temperatureC, 
      WeatherForecastFields.temperatureF: temperatureF,
      WeatherForecastFields.summary: summary
    };
}