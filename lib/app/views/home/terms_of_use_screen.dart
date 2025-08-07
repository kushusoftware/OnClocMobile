import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/controllers/home/terms_of_use_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/widgets/app_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnClocTermsOfUseScreen extends StatefulWidget {
  const OnClocTermsOfUseScreen({super.key});

  @override
  OnClocTermsOfUseScreenState createState() =>
      OnClocTermsOfUseScreenState();
}

class OnClocTermsOfUseScreenState extends State<OnClocTermsOfUseScreen> {
  final OnClocTermsOfUseController controller = Get.put(OnClocTermsOfUseController());
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocTermsOfUseController>(
      init: controller,
      tag: 'on_cloc_terms_conditions',
      builder: (_) => Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: onClocCommonAppBarWidget(context, 
          titleText:  onClocLocale.lblTermsConditionsScreenTitle),
          body: SafeArea(
            child: getFile(),
          ),
        ),
    );
  }

  Widget getFile() {
    return FutureBuilder<void>(
      future: controller.initWebView(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return WebViewWidget(controller: controller.webViewController);
        }
      },
    );
  }

}