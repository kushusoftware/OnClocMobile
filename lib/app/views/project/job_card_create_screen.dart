import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/controllers/project/job_card_create_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocJobCardCreateScreen extends StatefulWidget {
  const OnClocJobCardCreateScreen({super.key});

  @override
  State<OnClocJobCardCreateScreen> createState() => OnClocJobCardCreateScreenState();
}

class OnClocJobCardCreateScreenState extends State<OnClocJobCardCreateScreen> {
  final OnClocJobCardCreateController controller = Get.put(OnClocJobCardCreateController());
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocJobCardCreateController>(
      init: controller,
      tag: 'on_cloc_job_card_create',
      builder: (_) => Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: onClocCommonAppBarWidget(context,
          titleText: onClocLocale.lblJobCardCreateScreenTitle,
        ),
        body: Center(
          child: Text('Job Card Create Screen Content'),
        ),
      ),
    );
  }
}