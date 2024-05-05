import 'dart:developer';

import '../../../models/recipe_details.dart';
import 'package:get/get.dart';

import '../../../models/recipe.dart';
import '../../../services/network.dart';

class RecipeDetailsController extends GetxController {
  final network = Get.find<NetworkServices>();
  Rxn<RecipeDetails> recipe = Rxn();
  RxBool loading = RxBool(false);

  getDetails() async {
    loading.value = true;
    final response = await network.connectAPI(
      endPoint: 'recipes/${(Get.arguments as Recipe).id}/information',
      requestType: HTTPRequestType.get,
      header: {
        'X-RapidAPI-Key': '1a2bd7d529msh513ba3b70195a79p1acf77jsned01ab52cffa',
      },
    );
    loading.value = false;
    if (response?.data != null) {
      recipe.value = RecipeDetails.fromJson(response!.data!);
    }

    log(response!.data.toString());
  }

  @override
  void onInit() {
    getDetails();
    super.onInit();
  }
}
