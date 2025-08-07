import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/controllers/task/task_detial_controller.dart';

class OnClocTaskDetailScreen extends StatefulWidget {
  const OnClocTaskDetailScreen({super.key});

  @override
  OnClocTaskDetailScreenState createState() => OnClocTaskDetailScreenState();
}

class OnClocTaskDetailScreenState extends State<OnClocTaskDetailScreen> {
  final controller = Get.put(OnClocTaskDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Detail')),
      body: const Center(child: Text('Task Detail Screen')),
    );
  }
}
