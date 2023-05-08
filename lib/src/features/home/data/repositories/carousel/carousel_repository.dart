import 'package:fire_alert_mobile/src/features/home/data/models/carousel.dart';

abstract class CarouselRepository {
  Future<List<Carousel>> fetchCarousel();
}
