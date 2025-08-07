import 'package:get/get.dart';

class OnClocNavigationController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool isTabClick = false.obs;

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }

  void clickTab() {
    isTabClick.value = true;
    update();
  }
}