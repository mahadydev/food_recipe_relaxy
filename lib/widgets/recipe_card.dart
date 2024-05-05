import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/recipe.dart';
import '../routes/app_pages.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.recipeDetails, arguments: recipe);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(recipe.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        //
                        final list = ((GetStorage().read('recipe_list') ?? [])
                                as Iterable)
                            .map((e) => Recipe.fromJson(e))
                            .toList();

                        if (!list.contains(recipe)) {
                          list.add(recipe);
                          Get.snackbar('Added', 'Saved Recipe!');
                        } else {
                          list.remove(recipe);
                          Get.snackbar('Removed', 'Removed Recipe!');
                        }

                        GetStorage().write('recipe_list',
                            list.map((e) => e.toJson()).toList());
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        height: 40,
                        width: 40,
                        margin: const EdgeInsets.only(
                          right: 10,
                          top: 10,
                        ),
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
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          recipe.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
