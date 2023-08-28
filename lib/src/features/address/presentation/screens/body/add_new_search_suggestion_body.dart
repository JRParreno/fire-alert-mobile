import 'package:fire_alert_mobile/src/features/address/presentation/bloc/search_location/search_location_bloc.dart';
import 'package:fire_alert_mobile/src/features/address/presentation/screens/widgets/run_search_content/search_location_shimmer.dart';
import 'package:fire_alert_mobile/src/features/address/presentation/screens/widgets/search_address_suggestion_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewSearchSuggestionBody extends StatelessWidget {
  final TextEditingController searchController;
  const AddNewSearchSuggestionBody({
    super.key,
    required this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SearchLocationBloc>(context);
    return BlocBuilder(
      bloc: bloc,
      builder: (BuildContext context, SearchLocationState state) {
        if (state is SearchLocationLoading) {
          return const SearchLocationShimmer();
        }

        if (state is SearchLocationLoaded) {
          return SearchAddressSuggestionListWidget(
            suggestionList: state.suggestionPlaces,
          );
        }
        return const SizedBox();
      },
    );
  }
}
