import 'package:cached_network_image/cached_network_image.dart';
import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/shimmer.dart';
import 'package:fire_alert_mobile/src/core/config/app_constant.dart';
import 'package:fire_alert_mobile/src/features/home/data/models/carousel.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget {
  final Carousel carousel;
  final VoidCallback onTap;

  const CustomCarousel({
    super.key,
    required this.carousel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .85;

    return Padding(
      padding: const EdgeInsets.only(
        right: 8,
      ),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 156,
            width: width,
            clipBehavior: Clip.antiAlias,
            constraints: BoxConstraints(
                maxHeight: 156,
                maxWidth: MediaQuery.of(context).size.width * .85),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: CachedNetworkImage(
              imageUrl: carousel.imageUrl.isNotEmpty ? carousel.imageUrl : "",
              placeholder: (context, url) => Shimmer(
                linearGradient: AppConstant.shimmerGradient,
                child: ShimmerLoading(
                    isLoading: true,
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width * .85,
                        decoration: BoxDecoration(
                          color: ColorName.primary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    )),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
