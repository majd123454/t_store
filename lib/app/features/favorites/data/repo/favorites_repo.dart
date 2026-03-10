import 'package:first_project/app/features/favorites/data/models/favorites_model.dart';

abstract class FavoritesRepo {
  Future<List<FavoritesModel>> getFavorites();
}