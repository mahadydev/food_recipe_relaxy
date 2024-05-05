part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const String home = _Paths.home;
  static const String recipeDetails = _Paths.recipeDetails;
}

abstract class _Paths {
  _Paths._();
  static const home = '/home';
  static const recipeDetails = '/recipeDetails';
}
