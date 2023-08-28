import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/common_widget/shimmer.dart';
import 'package:fire_alert_mobile/src/core/config/app_constant.dart';
import 'package:flutter/material.dart';

class SearchLocationShimmer extends StatelessWidget {
  const SearchLocationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    const int itemLenght = 5;

    return ListView.builder(
      itemCount: itemLenght,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, int index) {
        return Shimmer(
          linearGradient: AppConstant.shimmerGradient,
          child: ShimmerLoading(
            isLoading: true,
            child: Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
              decoration: BoxDecoration(
                border: index < itemLenght - 1
                    ? const Border(
                        bottom: BorderSide(
                          width: .5,
                          color: ColorName.dimGray,
                        ),
                      )
                    : const Border.fromBorderSide(BorderSide.none),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 14,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: .9,
                        color: ColorName.gray,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 14,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: .9,
                        color: ColorName.gray,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
