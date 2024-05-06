import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
        () => controller.recipes.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LottieBuilder.network(
                    'https://lottie.host/14f520b4-f95a-405b-8324-236a9294ec44/GndgMfAs3i.json',
                  ),
                  const Text(
                    'No Recipe Found!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              )
            : ListView.builder(
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
