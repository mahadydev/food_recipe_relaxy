import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/recipe_card.dart';
import '../controllers/recipe_saved_controller.dart';

class RecipeSavedView extends StatelessWidget {
  const RecipeSavedView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecipeSavedController());
    controller.getRecipeFromStorage();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Recipes'),
      ),
      body: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.recipes.length,
          itemBuilder: (BuildContext context, int index) {
            return RecipeCard(recipe: controller.recipes[index]);
          },
        ),
      ),
    );
  }
}
