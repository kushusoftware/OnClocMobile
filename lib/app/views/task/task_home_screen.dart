import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:on_cloc_mobile/app/controllers/task/task_home_controller.dart';
import 'package:on_cloc_mobile/main.dart';
import 'package:on_cloc_mobile/theme/on_cloc_theme.dart';
import 'package:on_cloc_mobile/utilities/routes.dart';

class OnClocTaskHomeScreen extends StatefulWidget {
  const OnClocTaskHomeScreen({super.key});

  @override
  OnClocTaskHomeScreenState createState() => OnClocTaskHomeScreenState();
}

class OnClocTaskHomeScreenState extends State<OnClocTaskHomeScreen> {
  final OnClocTaskHomeController controller = Get.put(
    OnClocTaskHomeController(),
  );
  late ThemeData theme;

  @override
  void initState() {
    super.initState();
    theme = Get.isDarkMode ? OnClocTheme.darkTheme : OnClocTheme.lightTheme;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnClocTaskHomeController>(
      init: controller,
      tag: 'task_home',
      builder: (_) => DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  icon: const Icon(Iconsax.activity),
                  text: onClocLocale.lblOpenTasks,
                ),
                Tab(
                  icon: const Icon(Iconsax.check),
                  text: onClocLocale.lblCompletedTasks,
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Open Tasks Tab
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (controller.tasksList.isEmpty) {
                      return Center(
                        child: Text(onClocLocale.lblNoDataAvailable),
                      );
                    }
                    return ListView.builder(
                      itemCount: controller.tasksList.length,
                      itemBuilder: (context, index) {
                        final task = controller.tasksList[index];
                        return ListTile(
                          title: Text(task.taskInstruction),
                          subtitle: Text(task.technicalRemarks),
                          onTap: () {
                            controller.selectedTask = task;
                            Get.toNamed(OnClocRoutes.onClocTaskDetailScreen);
                          },
                        );
                      },
                    );
                  }),
                  // Completed Tasks Tab
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final completedTasks = controller.tasksList
                        .where((task) => task.isCompleted)
                        .toList();
                    if (completedTasks.isEmpty) {
                      return Center(
                        child: Text(onClocLocale.lblNoDataAvailable),
                      );
                    }
                    return ListView.builder(
                      itemCount: completedTasks.length,
                      itemBuilder: (context, index) {
                        final task = completedTasks[index];
                        return ListTile(
                          title: Text(task.taskInstruction),
                          subtitle: Text(task.technicalRemarks),

                          onTap: () {
                            controller.selectedTask = task;
                            Get.toNamed(OnClocRoutes.onClocTaskDetailScreen);
                          },
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
