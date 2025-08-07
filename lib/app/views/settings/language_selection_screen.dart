import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/app/controllers/settings/language_selection_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';

class OnClocLanguageSelectionScreen extends StatefulWidget {
  const OnClocLanguageSelectionScreen({super.key});

  @override
  State<OnClocLanguageSelectionScreen> createState() => OnClocLanguageSelectionScreenState();
}

class OnClocLanguageSelectionScreenState extends State<OnClocLanguageSelectionScreen> {
  OnClocLanguageSelectionController controller = Get.put(OnClocLanguageSelectionController());
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme =
        Get.isDarkMode
            ? OnClocTheme.darkTheme
            : OnClocTheme.lightTheme; // Replace with your theme logic
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocLanguageSelectionController>(
      init: controller,
      tag: 'on_cloc_language_selection',
      builder:
          (controller) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: onClocCommonAppBarWidget(
              context,
              titleText: onClocLocale.lblLanguageSelectionTitle,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Language selection widget
                    LanguageListWidget(
                      widgetType: WidgetType.LIST,
                      onLanguageChange: (value) async {
                        await mainStore.setLanguage(
                          value.languageCode ?? getStringAsync(languagePref),
                          context: context,
                        );
                        setState(() {
                          Get.updateLocale(Locale(value.languageCode!));
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
