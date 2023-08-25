part of 'home_carousel_bloc.dart';

class HomeCarouselState extends Equatable {
  const HomeCarouselState();

  @override
  List<Object> get props => [];
}

class HomeCarouselLoaded extends HomeCarouselState {
  final List<Carousel> carousels;
  final int index;

  const HomeCarouselLoaded({
    required this.carousels,
    this.index = 0,
  });

  @override
  List<Object> get props => [
        carousels,
        index,
      ];

  HomeCarouselLoaded copyWith({
    List<Carousel>? carousels,
    int? index,
  }) {
    return HomeCarouselLoaded(
      carousels: carousels ?? this.carousels,
      index: index ?? this.index,
    );
  }
}
