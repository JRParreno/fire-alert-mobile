import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fire_alert_mobile/src/core/bloc/common/common_state.dart';
import 'package:fire_alert_mobile/src/features/home/data/models/carousel.dart';
import 'package:fire_alert_mobile/src/features/home/data/repositories/carousel/carousel_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_carousel_event.dart';
part 'home_carousel_state.dart';

class HomeCarouselBloc extends Bloc<HomeCarouselEvent, HomeCarouselState> {
  final CarouselRepository _carouselRepository;

  HomeCarouselBloc(this._carouselRepository) : super(const InitialState()) {
    on<GetHomeCarouselEvent>(_onGetHomeCarouselEvent);
    on<OnChangedCarousel>(_onChangedCarousel);
  }

  FutureOr<void> _onGetHomeCarouselEvent(
      GetHomeCarouselEvent event, Emitter<HomeCarouselState> emit) async {
    emit(const LoadingState());

    try {
      final carousels = await _carouselRepository.fetchCarousel();
      emit(HomeCarouselLoaded(carousels: carousels));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  FutureOr<void> _onChangedCarousel(
      OnChangedCarousel event, Emitter<HomeCarouselState> emit) async {
    final state = this.state;

    if (state is HomeCarouselLoaded) {
      emit(state.copyWith(index: event.index));
    }
  }
}
