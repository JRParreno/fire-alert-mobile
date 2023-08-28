import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/location/place_detail.dart';
import 'package:flutter/material.dart';

class SavedAddressTile extends StatelessWidget {
  final PlaceDetail address;
  final bool isBorderLine;
  final bool isFirstItem;
  final bool isFromProfile;

  const SavedAddressTile({
    super.key,
    required this.address,
    this.isBorderLine = false,
    this.isFirstItem = false,
    this.isFromProfile = false,
  });

  PlaceDetail getNewPlaceDetail() {
    return PlaceDetail(
      formattedAddress: address.formattedAddress,
      lat: address.lat,
      lng: address.lng,
      placeName: address.placeName,
      placeId: address.placeId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding:
            EdgeInsets.only(top: isFirstItem ? 0.0 : 20, bottom: 20, right: 20),
        decoration: BoxDecoration(
          border: isBorderLine
              ? const Border(
                  bottom: BorderSide(
                    width: .5,
                    color: ColorName.dimGray,
                  ),
                )
              : const Border.fromBorderSide(BorderSide.none),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10, top: 10, left: 3),
              child: const Icon(Icons.location_city),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address.formattedAddress),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
