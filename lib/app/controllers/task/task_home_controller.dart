import 'package:get/get.dart';
import 'package:on_cloc_mobile/app/models/task/on_cloc_task.dart';

class OnClocTaskHomeController extends GetxController {
  var isLoading = false.obs;
  var tasksList = <OnClocTask>[].obs;
  OnClocTask? selectedTask;
}
