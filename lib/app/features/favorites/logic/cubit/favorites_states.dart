import 'package:equatable/equatable.dart';
import 'package:first_project/app/features/favorites/data/models/favorites_model.dart';

abstract class FavoritesStates  extends Equatable {}

class FavoritesInitial extends FavoritesStates {
  @override
  List<Object?> get props => [];
}

class FavoritesLoaded extends FavoritesStates {
  final List<FavoritesModel> favorites;

  FavoritesLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

class FavoritesError extends FavoritesStates {
  final String message;

  FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}

class FavoritesLoading extends FavoritesStates {
  @override
  List<Object?> get props => [];
}