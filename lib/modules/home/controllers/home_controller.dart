import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currentIndex = RxInt(0);
  PageController pageController = PageController();

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
