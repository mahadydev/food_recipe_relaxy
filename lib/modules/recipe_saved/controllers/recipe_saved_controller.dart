import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/recipe.dart';

class RecipeSavedController extends GetxController {
  RxList<Recipe> recipes = RxList.of([]);

  void getRecipeFromStorage() {
    recipes.value = ((GetStorage().read('recipe_list') ?? []) as Iterable)
        .map((e) => Recipe.fromJson(e))
        .toList();

    GetStorage().listenKey('recipe_list', (value) {
      recipes.value =
          (value as Iterable).map((e) => Recipe.fromJson(e)).toList();
    });
  }

  @override
  void onInit() {
    getRecipeFromStorage();
    super.onInit();
  }
}
