import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/service/google_service.dart';
import 'package:fire_alert_mobile/src/features/address/data/models/suggestion.dart';
import 'package:fire_alert_mobile/src/features/address/presentation/screens/widgets/run_search_content/search_location_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SearchAddressSuggestionListWidget extends StatelessWidget {
  const SearchAddressSuggestionListWidget({
    super.key,
    required this.suggestionList,
  });
  final List<Suggestion> suggestionList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: suggestionList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () async {
                EasyLoading.show();

                final response = await GoogleService()
                    .getPlaceDetailsById(suggestionList[index].placeId);
                EasyLoading.dismiss();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(response);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: index < suggestionList.length - 1
                      ? const Border(
                          bottom: BorderSide(
                            width: .5,
                            color: ColorName.placeHolder,
                          ),
                        )
                      : const Border.fromBorderSide(BorderSide.none),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: SearchLocationTile(
                  suggestionPlace: suggestionList[index],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
