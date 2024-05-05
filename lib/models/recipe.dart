import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';
part 'recipe.g.dart';

/// The response of the `GET /api/activity` endpoint.
///
/// It is defined using `freezed` and `json_serializable`.
@freezed
class Recipe with _$Recipe {
  factory Recipe({
    required int id,
    required String title,
    required String image,
    required String imageType,
  }) = _Recipe;

  /// Convert a JSON object into an [Recipe] instance.
  /// This enables type-safe reading of the API response.
  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
}
