import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/controllers/location/get_location_controller.dart';

class OnClocGetLocationScreen extends StatefulWidget {
  const OnClocGetLocationScreen({super.key});

  @override
  State<OnClocGetLocationScreen> createState() => OnClocGetLocationScreenState();
}

class OnClocGetLocationScreenState extends State<OnClocGetLocationScreen> {
  final OnClocGetLocationController controller = Get.put(OnClocGetLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Get Location'),
      ),
      body: Center(
        child: Text('Location: '),
      ),
    );
  }
}