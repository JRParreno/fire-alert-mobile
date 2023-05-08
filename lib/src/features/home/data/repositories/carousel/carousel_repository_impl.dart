import 'package:dio/dio.dart';
import 'package:fire_alert_mobile/src/core/config/app_constant.dart';
import 'package:fire_alert_mobile/src/features/home/data/models/carousel.dart';
import 'package:fire_alert_mobile/src/features/home/data/repositories/carousel/carousel_repository.dart';

class CarouselRepositoryImpl extends CarouselRepository {
  final Dio dio = Dio();

  @override
  Future<List<Carousel>> fetchCarousel() async {
    const String url = '${AppConstant.apiUrl}/carousel';

    return await dio.get(url).then((value) {
      final results = value.data['results'];
      List<Carousel> carousels = [];
      for (var i = 0; i < results.length; i++) {
        final element = results[i];
        carousels.add(Carousel.fromMap(element));
      }
      return carousels;
    }).catchError((onError) {
      throw onError;
    });
  }
}
