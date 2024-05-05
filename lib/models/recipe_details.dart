import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_details.freezed.dart';
part 'recipe_details.g.dart';

@freezed
class RecipeDetails with _$RecipeDetails {
  const factory RecipeDetails({
    bool? vegetarian,
    bool? vegan,
    bool? glutenFree,
    bool? dairyFree,
    bool? veryHealthy,
    bool? cheap,
    bool? veryPopular,
    bool? sustainable,
    bool? lowFodmap,
    int? weightWatcherSmartPoints,
    String? gaps,
    int? preparationMinutes,
    int? cookingMinutes,
    int? aggregateLikes,
    int? healthScore,
    String? creditsText,
    String? sourceName,
    double? pricePerServing,
    List<ExtendedIngredient>? extendedIngredients,
    int? id,
    String? title,
    int? readyInMinutes,
    int? servings,
    String? sourceUrl,
    String? image,
    String? imageType,
    Taste? taste,
    String? summary,
    List<dynamic>? cuisines,
    List<String>? dishTypes,
    List<String>? diets,
    List<dynamic>? occasions,
    WinePairing? winePairing,
    String? instructions,
    List<AnalyzedInstruction>? analyzedInstructions,
    dynamic originalId,
    double? spoonacularScore,
  }) = _RecipeDetails;

  factory RecipeDetails.fromJson(Map<String, dynamic> json) =>
      _$RecipeDetailsFromJson(json);
}

@freezed
class AnalyzedInstruction with _$AnalyzedInstruction {
  const factory AnalyzedInstruction({
    String? name,
    List<Step>? steps,
  }) = _AnalyzedInstruction;

  factory AnalyzedInstruction.fromJson(Map<String, dynamic> json) =>
      _$AnalyzedInstructionFromJson(json);
}

@freezed
class Step with _$Step {
  const factory Step({
    int? number,
    String? step,
    List<Ingredient>? ingredients,
    List<dynamic>? equipment,
  }) = _Step;

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);
}

@freezed
class Ingredient with _$Ingredient {
  const factory Ingredient({
    int? id,
    String? name,
    String? localizedName,
    String? image,
  }) = _Ingredient;

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);
}

@freezed
class ExtendedIngredient with _$ExtendedIngredient {
  const factory ExtendedIngredient({
    int? id,
    String? aisle,
    String? image,
    String? consistency,
    String? name,
    String? nameClean,
    String? original,
    String? originalName,
    int? amount,
    String? unit,
    List<dynamic>? meta,
    Measures? measures,
  }) = _ExtendedIngredient;

  factory ExtendedIngredient.fromJson(Map<String, dynamic> json) =>
      _$ExtendedIngredientFromJson(json);
}

@freezed
class Measures with _$Measures {
  const factory Measures({
    Us? us,
    Metric? metric,
  }) = _Measures;

  factory Measures.fromJson(Map<String, dynamic> json) =>
      _$MeasuresFromJson(json);
}

@freezed
class Metric with _$Metric {
  const factory Metric({
    int? amount,
    String? unitShort,
    String? unitLong,
  }) = _Metric;

  factory Metric.fromJson(Map<String, dynamic> json) => _$MetricFromJson(json);
}

@freezed
class Us with _$Us {
  const factory Us({
    double? amount,
    String? unitShort,
    String? unitLong,
  }) = _Us;

  factory Us.fromJson(Map<String, dynamic> json) => _$UsFromJson(json);
}

@freezed
class Taste with _$Taste {
  const factory Taste({
    double? sweetness,
    double? saltiness,
    double? sourness,
    int? bitterness,
    int? savoriness,
    double? fattiness,
    int? spiciness,
  }) = _Taste;

  factory Taste.fromJson(Map<String, dynamic> json) => _$TasteFromJson(json);
}

@freezed
class WinePairing with _$WinePairing {
  const factory WinePairing({
    List<dynamic>? pairedWines,
    String? pairingText,
    List<dynamic>? productMatches,
  }) = _WinePairing;

  factory WinePairing.fromJson(Map<String, dynamic> json) =>
      _$WinePairingFromJson(json);
}
