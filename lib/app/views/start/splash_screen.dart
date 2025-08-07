import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/controllers/start/splash_controller.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/assets.dart';

class OnClocSplashScreen extends StatefulWidget {
  const OnClocSplashScreen({super.key});

  @override
  OnClocSplashScreenState createState() => OnClocSplashScreenState();
}

class OnClocSplashScreenState extends State<OnClocSplashScreen> {
  final OnClocSplashController controller = Get.put(OnClocSplashController());
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme =
        Get.isDarkMode
            ? OnClocTheme.darkTheme
            : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocSplashController>(
      init: controller,
      tag: 'on_cloc_splash',
      builder: (_) => Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(onClocSplashBg),
                  fit: BoxFit
                      .fill, // This ensures that the image covers the entire container
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  onClocLogoWhite,
                  height: 81,
                  width: 105,
                ),
              ),
            ),
        ),
    );
  }
}
