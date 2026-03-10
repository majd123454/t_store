import 'package:first_project/app/features/favorites/data/datasources/favorites_data_source.dart';
import 'package:first_project/app/features/favorites/data/models/favorites_model.dart';
import 'package:first_project/app/features/favorites/data/repo/favorites_repo.dart';

class FavoritesRepoImpl extends FavoritesRepo {
  final FavoritesDataSource dataSource;
  FavoritesRepoImpl({required this.dataSource});
  @override
  Future<List<FavoritesModel>> getFavorites() async {
    try {
      final List<Map<String,dynamic>> favorites = await dataSource.fetchFavorites();
      return favorites.map((favorite) => FavoritesModel.fromJson(favorite)).toList();
    } catch (e) {
      throw Exception("Failed to fetch favorites: ${e.toString()}");
    }
  }
}