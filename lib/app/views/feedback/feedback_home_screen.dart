import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/controllers/feedback/feedback_home_controller.dart';

class OnClocFeedbackHomeScreen extends StatefulWidget {
  const OnClocFeedbackHomeScreen({super.key});

  @override
  OnClocFeedbackHomeScreenState createState() => OnClocFeedbackHomeScreenState();
}

class OnClocFeedbackHomeScreenState extends State<OnClocFeedbackHomeScreen> {
  final OnClocFeedbackHomeController controller = Get.put(OnClocFeedbackHomeController());

  @override
  void initState() {
    super.initState();
    // Fetch initial feedback data
    controller.fetchFeedbackData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback Home'),
      ),
      body: Center(
        child: Text(
          'Welcome to the Feedback Home Screen',
          ),
      ),
    );
  }
}