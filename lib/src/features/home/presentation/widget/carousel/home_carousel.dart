import 'package:carousel_slider/carousel_slider.dart';
import 'package:fire_alert_mobile/src/features/home/data/models/carousel.dart';
import 'package:fire_alert_mobile/src/features/home/presentation/widget/carousel/custom_carousel.dart';
import 'package:flutter/material.dart';

class HomeCarousel extends StatelessWidget {
  final List<Carousel> carousels;
  final Function(int value) onChanged;

  const HomeCarousel({
    super.key,
    required this.carousels,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider.builder(
        itemCount: carousels.length,
        itemBuilder: (context, index, idx) {
          return CustomCarousel(
            carousel: carousels[index],
            onTap: () {},
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          enableInfiniteScroll: carousels.length > 1,
          onPageChanged: (index, reason) {
            onChanged(index);
          },
        ),
      ),
    );
  }
}
