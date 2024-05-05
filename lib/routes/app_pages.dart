import 'package:get/get.dart';

import '../modules/home/views/home_view.dart';
import '../modules/recipe_details/views/recipe_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const String initialPage = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: _Paths.recipeDetails,
      page: () => const RecipeDetailsView(),
    ),
  ];
}
