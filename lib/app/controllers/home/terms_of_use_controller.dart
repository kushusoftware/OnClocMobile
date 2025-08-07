import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/utilities/colors.dart';
import 'package:on_cloc_mobile/utilities/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OnClocTermsOfUseController extends GetxController {
  String termsOfUseUrl = getStringAsync(termsOfUseUrlPref);
  late WebViewController webViewController;

  @override
  void onInit() {
    getTargetUrl();
    super.onInit();
    webViewController = WebViewController();
    initWebView();
  }

  Future<void> initWebView() async {
    String headingColor =
        Get.isDarkMode
            ? '#FFFFFF'
            : '#333333'; // Dark mode: white, Light mode: dark gray
    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(
        Get.isDarkMode ? servpalPrimaryColor : onClocWhiteColor,
      )
      ..loadRequest(Uri.parse(termsOfUseUrl))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            webViewController.runJavaScript(
              "document.documentElement.style.setProperty('--heading-color', '$headingColor');",
            );
          },
        ),
      );
  }

  void getTargetUrl() async {
    await onClocSharedHelper.refreshAppSettings();
    if (onClocSharedHelper.isSettingsRefreshed()) {
      termsOfUseUrl = getStringAsync(termsOfUseUrlPref);
    }
  }
}
