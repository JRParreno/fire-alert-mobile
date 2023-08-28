import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/features/address/data/models/suggestion.dart';
import 'package:flutter/material.dart';

class SearchLocationTile extends StatelessWidget {
  const SearchLocationTile({
    super.key,
    required this.suggestionPlace,
  });

  final Suggestion suggestionPlace;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 8, top: 8),
          child: const Icon(
            Icons.location_pin,
            size: 17,
            color: ColorName.dimGray,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(suggestionPlace.mainText),
              Text(suggestionPlace.secondaryText),
            ],
          ),
        )
      ],
    );
  }
}
