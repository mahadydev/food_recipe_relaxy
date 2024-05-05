import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../recipe_saved/views/recipe_saved_view.dart';
import '../../recipe_search/views/recipe_search_view.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: (value) {
          controller.currentIndex.value = value;
          controller.pageController.jumpToPage(value);
        },
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/home.svg'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/book.svg'),
            label: '',
          ),
        ],
      ),
      body: PageView(
        controller: controller.pageController,
        onPageChanged: (value) {
          controller.currentIndex.value = value;
        },
        children: const [
          RecipeSearchView(),
          RecipeSavedView(),
        ],
      ),
    );
  }
}
