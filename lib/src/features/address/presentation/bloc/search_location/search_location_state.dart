part of 'search_location_bloc.dart';

@immutable
abstract class SearchLocationState extends Equatable {
  const SearchLocationState();
  @override
  List<Object?> get props => [];
}

class SearchLocationInitial extends SearchLocationState {}

class SearchLocationLoaded extends SearchLocationState {
  final List<Suggestion> suggestionPlaces;

  const SearchLocationLoaded({
    required this.suggestionPlaces,
  });

  @override
  List<Object?> get props => [
        suggestionPlaces,
      ];
}

class SearchLocationLoading extends SearchLocationState {}

class SearchLocationError extends SearchLocationState {}
