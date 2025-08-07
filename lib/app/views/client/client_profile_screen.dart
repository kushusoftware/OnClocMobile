import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/controllers/client/client_profile_controller.dart';

class OnClocClientProfileScreen extends StatefulWidget {
  const OnClocClientProfileScreen({super.key});

  @override
  State<OnClocClientProfileScreen> createState() => OnClocClientProfileScreenState();
}

class OnClocClientProfileScreenState extends State<OnClocClientProfileScreen> {
  final OnClocClientProfileController controller = Get.put(OnClocClientProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Profile'),
      ),
      body: const Center(
        child: Text('Client Profile Details'),
      ),
    );
  }
}