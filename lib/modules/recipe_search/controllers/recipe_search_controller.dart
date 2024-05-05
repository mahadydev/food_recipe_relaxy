import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../models/recipe.dart';
import '../../../services/network.dart';

class RecipeSearchController extends GetxController {
  final network = Get.find<NetworkServices>();
  final searchController = TextEditingController();
  RxList<Recipe> recipes = RxList.of([]);
  RxBool loading = RxBool(false);
  final ScrollController scrollController = ScrollController();

  int perPage = 20;
  int offset = 0;

  Future<void> getRecipe() async {
    loading.value = true;
    final response = await network.connectAPI(
      endPoint: 'recipes/complexSearch',
      requestType: HTTPRequestType.get,
      header: {
        'X-RapidAPI-Key': '1a2bd7d529msh513ba3b70195a79p1acf77jsned01ab52cffa',
      },
      queryParameters: {
        'query': searchController.text,
        'number': perPage,
        'offset': offset,
      },
    );
    loading.value = false;
    if (response?.data != null) {
      final list = (response!.data['results'] as Iterable)
          .map((e) => Recipe.fromJson(e))
          .toList();
      recipes.addAll(list);
    }
  }

  void resetRecipe() {
    offset = 0;
    recipes.clear();
  }

  _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      offset += perPage;
      await getRecipe();
    }
  }

  @override
  void onInit() {
    getRecipe();
    scrollController.addListener(_scrollListener);
    super.onInit();
  }

  @override
  void onClose() {
    searchController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
