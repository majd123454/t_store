import 'package:first_project/app/features/favorites/data/models/favorites_model.dart';
import 'package:first_project/app/features/favorites/data/repo/favorites_repo.dart';

class GetFavoritesUseCase {
  final FavoritesRepo repository;
  GetFavoritesUseCase({required this.repository});

  Future<List<FavoritesModel>> call() async {
    return await repository.getFavorites();
  }
}