import 'package:get/get.dart';

class Status {
  final String name;
  final RxBool isSelected;

  Status(this.name, {bool isSelected = false})
      : isSelected = isSelected.obs;
}