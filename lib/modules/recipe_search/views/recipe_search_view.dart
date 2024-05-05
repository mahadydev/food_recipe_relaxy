import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../widgets/recipe_card.dart';
import '../controllers/recipe_search_controller.dart';

class RecipeSearchView extends StatelessWidget {
  const RecipeSearchView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecipeSearchController());

    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/yummy_logo.svg'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color(0xFFF1F1F5),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: TextField(
                controller: controller.searchController,
                onChanged: (value) {
                  controller.resetRecipe();
                },
                decoration: InputDecoration(
                  hintText: 'Write Recipe Name',
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF94959B),
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      controller.getRecipe();
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Color(0xFF94959B),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => Stack(
                  children: [
                    ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.recipes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RecipeCard(recipe: controller.recipes[index]);
                      },
                    ),
                    controller.loading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
