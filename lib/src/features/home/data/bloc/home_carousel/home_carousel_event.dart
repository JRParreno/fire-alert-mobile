part of 'home_carousel_bloc.dart';

class HomeCarouselEvent extends Equatable {
  const HomeCarouselEvent();

  @override
  List<Object> get props => [];
}

class GetHomeCarouselEvent extends HomeCarouselEvent {}

class OnChangedCarousel extends HomeCarouselEvent {
  const OnChangedCarousel(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}
