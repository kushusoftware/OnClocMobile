import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/controllers/profile/enrol_controller.dart';

class OnClocEnrolScreen extends StatefulWidget {
  const OnClocEnrolScreen({super.key});

  @override
  OnClocEnrolScreenState createState() => OnClocEnrolScreenState();
}

class OnClocEnrolScreenState extends State<OnClocEnrolScreen> {
  final OnClocEnrolController controller = Get.put(OnClocEnrolController());
  late ThemeData theme;
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocEnrolController>(
      init: controller,
      tag: 'on_cloc_enrol',
      builder: (_) => Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('Enrol Screen'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}