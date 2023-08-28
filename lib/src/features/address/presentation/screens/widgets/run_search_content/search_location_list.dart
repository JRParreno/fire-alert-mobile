import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/utils/size_config.dart';
import 'package:fire_alert_mobile/src/features/address/data/models/suggestion.dart';
import 'package:fire_alert_mobile/src/features/address/presentation/screens/widgets/run_search_content/search_location_tile.dart';
import 'package:flutter/material.dart';

class SearchLocationList extends StatelessWidget {
  final List<Suggestion> suggestionList;

  const SearchLocationList({
    super.key,
    required this.suggestionList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          itemCount: suggestionList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                border: index < suggestionList.length - 1
                    ? const Border(
                        bottom: BorderSide(
                          width: .5,
                          color: ColorName.gray,
                        ),
                      )
                    : const Border.fromBorderSide(BorderSide.none),
              ),
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.getProportionateScreenHeight(16)),
              child: SearchLocationTile(
                suggestionPlace: suggestionList[index],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
