import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/controllers/device/device_status_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocDeviceStatusScreen extends StatefulWidget {
  const OnClocDeviceStatusScreen({super.key});

  @override
  State<OnClocDeviceStatusScreen> createState() => OnClocDeviceStatusScreenState();
}

class OnClocDeviceStatusScreenState extends State<OnClocDeviceStatusScreen> {
  final OnClocDeviceStatusController controller = Get.put(OnClocDeviceStatusController());
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocDeviceStatusController>(
      init: controller,
      tag: 'on_cloc_device_status',
      builder: (_) => Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: onClocCommonAppBarWidget(
          context,
          titleText: onClocLocale.lblDeviceStatusTitle,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Center(
             child: Column(
              children: [
                // Add your device status widgets here
                
              ],
            ),
          ),
          ),
        ),
      ),
    );
  }
}