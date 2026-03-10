import 'package:first_project/app/features/favorites/logic/cubit/favorites_states.dart';
import 'package:first_project/app/features/favorites/logic/usecases/favorites_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  final GetFavoritesUseCase getFavoritesUseCase;
  FavoritesCubit({required this.getFavoritesUseCase}) : super(FavoritesInitial());

  void getFavorites() async {
    emit(FavoritesLoading());
    try {
      final result = await getFavoritesUseCase();
      if (result.isEmpty) {
        emit(FavoritesError("No favorites found"));
      } else {
        emit(FavoritesLoaded(result));
      }
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  // void removeFromFavorites(String item) {
  //   final currentState = state;
  //   if (currentState is FavoritesLoaded) {
  //     final updatedFavorites = List<String>.from(currentState.favorites)..remove(item);
  //     emit(FavoritesLoaded(updatedFavorites));
  //   } 
  // }
}