import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/models/weather/weather_forecast_model.dart';
import 'package:on_cloc_mobile/main.dart';

class WeatherForecastController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<WeatherForecast> weatherForecastList = <WeatherForecast>[].obs;

  Future<RxList<WeatherForecast>> getWeatherForecast() async {
    isLoading.value = true;
    var weatherForecast = await onClocApiService.getWeatherForecast();
    weatherForecastList = weatherForecast.obs;
    isLoading.value = false;
    return weatherForecastList;
  }
}