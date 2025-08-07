import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/weather/weather_forecast_controller.dart';
import 'package:on_cloc_mobile/app/models/weather/weather_forecast_model.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  State<WeatherForecastScreen> createState() => WeatherForecastScreenState();
}

class WeatherForecastScreenState extends State<WeatherForecastScreen> {
  final WeatherForecastController controller = Get.put(WeatherForecastController());

  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme =
        Get.isDarkMode
            ? OnClocTheme.darkTheme
            : OnClocTheme.lightTheme;
  }

  double horizontalPadding = 15.0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherForecastController>(
      init: controller,
      tag: 'weather_forcast',
      builder:
          (controller) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: onClocCommonAppBarWidget(
              context,
              titleText: 'Weather Forcast (Test)',
            ),
            body: SafeArea(child: buildWeatherForcast()),
          ),
    );
  }

  Widget buildWeatherForcast() {
    return Center(
      child: FutureBuilder<List<WeatherForecast>>(
        future: controller.getWeatherForecast(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(color: servpalPrimaryColor);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return controller.weatherForecastList.isEmpty
                ? Text(onClocLocale.lblNoDataAvailable)
                : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.weatherForecastList.length,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    WeatherForecast data = controller.weatherForecastList[index];
                    return Container(
                      margin: EdgeInsets.only(
                        left: horizontalPadding,
                        top: (index == 0) ? 10 : 8,
                        bottom:
                            (index == controller.weatherForecastList.length - 1)
                                ? 50
                                : 8,
                        right: horizontalPadding,
                      ),
                      decoration: BoxDecoration(
                        color:
                            Get.isDarkMode
                                ? onClocGreyColor.withValues(alpha: 0.05)
                                : Colors.white,
                        border: Border.all(
                          color:
                              Get.isDarkMode
                                  ? onClocGreyColor.withValues(alpha: 0.10)
                                  : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 110,
                            offset: const Offset(0, 55),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 12,
                            height: 89,
                            decoration: BoxDecoration(
                              color:
                                  Get.isDarkMode
                                      ? Colors.white.withValues(alpha: 0.10)
                                      : servpalPrimaryColor.withValues(
                                        alpha: 0.10,
                                      ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        onClocHolidayIcon,
                                        width: 24,
                                        height: 24,
                                        colorFilter: ColorFilter.mode(
                                          Get.isDarkMode
                                              ? servpalTextColorDark
                                              : servpalTextColorLight,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      10.width,
                                      Expanded(
                                        child: Text(
                                          onClocFormatter.format(data.date),
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      2.width,
                                      Text(
                                        getDayFromDate(data.date),
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                              color:
                                                  Get.isDarkMode
                                                      ? Colors.white
                                                      : onClocGreyColor,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                      10.width,
                                    ],
                                  ),
                                  5.height,
                                  Text(
                                    '${data.temperatureC} C | ${data.temperatureF} F',
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  5.height,
                                  Text(
                                    data.summary!,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
          }
        },
      ),
    );
  }

  String getDayFromDate(DateTime inputDateTime) {
    int dayOfWeek = inputDateTime.weekday;
    String dayString = _getDayOfWeekString(dayOfWeek);
    return dayString;
  }

  String _getDayOfWeekString(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'Unknown';
    }
  }
}
