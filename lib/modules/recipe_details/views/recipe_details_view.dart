import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/recipe.dart';
import '../controllers/recipe_details_controller.dart';

class RecipeDetailsView extends StatelessWidget {
  const RecipeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RecipeDetailsController());

    return Scaffold(
      body: Obx(
        () => controller.recipe.value == null
            ? const Center(child: CircularProgressIndicator())
            : NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    leading: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                          color: Colors.white,
                        ),
                        child: SvgPicture.asset('assets/close.svg'),
                      ),
                    ),
                    expandedHeight: 250.0,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                        tag: controller.recipe.value!.id!,
                        child: CachedNetworkImage(
                          imageUrl: controller.recipe.value!.image!,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Center(child: Icon(Icons.error)),
                        ),
                      ),
                    ),
                    actions: [
                      InkWell(
                        onTap: () {
                          final list = ((GetStorage().read('recipe_list') ?? [])
                                  as Iterable)
                              .map((e) => Recipe.fromJson(e))
                              .toList();

                          if (!list.contains(Get.arguments as Recipe)) {
                            list.add(Get.arguments);
                            Get.snackbar('Added', 'Saved Recipe!');
                          } else {
                            list.remove(Get.arguments);
                            Get.snackbar('Removed', 'Removed Recipe!');
                          }

                          GetStorage().write('recipe_list',
                              list.map((e) => e.toJson()).toList());
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                            color: Colors.white,
                          ),
                          child: SvgPicture.asset('assets/Save.svg'),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.recipe.value!.title ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 40,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      controller.recipe.value!.diets?.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Chip(
                                        padding: EdgeInsets.zero,
                                        label: Text(controller
                                            .recipe.value!.diets![index]),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Chip(
                              padding: EdgeInsets.zero,
                              label: Row(
                                children: [
                                  SvgPicture.asset('assets/timer.svg'),
                                  const SizedBox(width: 5.0),
                                  Text(
                                      '${controller.recipe.value!.readyInMinutes!} mins'),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Divider(thickness: 1.0),
                        HtmlWidget(
                          controller.recipe.value!.summary!,
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Ingredients:',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.only(top: 10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller
                              .recipe.value!.extendedIngredients!.length,
                          itemBuilder: (context, index) {
                            final ingredient = controller
                                .recipe.value!.extendedIngredients![index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://spoonacular.com/cdn/ingredients_100x100/${ingredient.image}',
                                ),
                              ),
                              title: Text(
                                  '${ingredient.amount} ${ingredient.unit} ${ingredient.nameClean}'),
                            );
                          },
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Instructions:',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10.0),
                        ListView.builder(
                          padding: const EdgeInsets.only(top: 10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.recipe.value!
                              .analyzedInstructions![0].steps!.length,
                          itemBuilder: (context, index) {
                            final step = controller.recipe.value!
                                .analyzedInstructions![0].steps![index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.green,
                                child: Text(
                                  '${step.number}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(step.step!),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
