part of 'search_location_bloc.dart';

@immutable
abstract class SearchLocationEvent extends Equatable {
  const SearchLocationEvent();

  @override
  List<Object?> get props => [];
}

class AddSearchLocationEvent extends SearchLocationEvent {
  final String searchText;

  const AddSearchLocationEvent({
    required this.searchText,
  });

  @override
  List<Object?> get props => [
        searchText,
      ];
}

class SearchSuggestionPlaceEvent extends SearchLocationEvent {
  final String searchText;

  const SearchSuggestionPlaceEvent({
    required this.searchText,
  });

  @override
  List<Object?> get props => [
        searchText,
      ];
}

class SetLoadingSearchLocation extends SearchLocationEvent {}

class SetInitialSearchLocation extends SearchLocationEvent {}
