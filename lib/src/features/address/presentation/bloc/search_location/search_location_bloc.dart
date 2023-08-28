import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:fire_alert_mobile/src/features/address/data/models/suggestion.dart';
import 'package:fire_alert_mobile/src/features/address/data/repositories/address_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_location_event.dart';
part 'search_location_state.dart';

class SearchLocationBloc
    extends Bloc<SearchLocationEvent, SearchLocationState> {
  final AddressRepositoryImpl _addressRepositoryImpl;

  SearchLocationBloc(this._addressRepositoryImpl)
      : super(SearchLocationInitial()) {
    on<AddSearchLocationEvent>(_addSearchLocationEvent,
        transformer: restartable());
    on<SetLoadingSearchLocation>(_setLoadingSearchLocation);
    on<SetInitialSearchLocation>(_setInitialSearchLocation);
    on<SearchSuggestionPlaceEvent>(_searchSuggestionPlace);
  }

  FutureOr<void> _searchSuggestionPlace(
    SearchSuggestionPlaceEvent event,
    Emitter<SearchLocationState> emit,
  ) async {
    emit(SearchLocationLoading());
    try {
      final places =
          await _addressRepositoryImpl.fetchSuggestion(event.searchText);
      emit(SearchLocationLoaded(suggestionPlaces: places));
    } catch (e) {
      // catch error in google api
      emit(SearchLocationError());
    }
  }

  Future<void> _addSearchLocationEvent(
      AddSearchLocationEvent event, Emitter<SearchLocationState> emit) async {
    List<Suggestion> places = [];
    try {
      places = await _addressRepositoryImpl.fetchSuggestion(event.searchText);
      emit(SearchLocationLoaded(suggestionPlaces: places));
    } catch (e) {
      // catch error in google api
      return emit(SearchLocationError());
    }
    return emit(SearchLocationLoaded(suggestionPlaces: places));
  }

  void _setLoadingSearchLocation(
      SetLoadingSearchLocation event, Emitter<SearchLocationState> emit) {
    return emit(SearchLocationLoading());
  }

  void _setInitialSearchLocation(
      SetInitialSearchLocation event, Emitter<SearchLocationState> emit) {
    return emit(SearchLocationInitial());
  }
}
