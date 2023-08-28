import 'package:easy_debounce/easy_debounce.dart';
import 'package:fire_alert_mobile/gen/colors.gen.dart';
import 'package:fire_alert_mobile/src/core/location/get_current_location.dart';
import 'package:fire_alert_mobile/src/core/permission/app_permission.dart';
import 'package:fire_alert_mobile/src/features/address/presentation/bloc/search_location/search_location_bloc.dart';
import 'package:fire_alert_mobile/src/features/address/presentation/screens/body/add_new_search_suggestion_body.dart';
import 'package:fire_alert_mobile/src/features/address/presentation/screens/widgets/add_new_search_screen_app_bar_widget.dart';
import 'package:fire_alert_mobile/src/features/address/presentation/screens/widgets/initial_content/use_current_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddNewSearchAddressScreen extends StatefulWidget {
  static const String routeName = '/add-new-search-address-screen';

  const AddNewSearchAddressScreen({
    super.key,
  });

  @override
  State<AddNewSearchAddressScreen> createState() =>
      _AddNewSearchAddressScreenState();
}

class _AddNewSearchAddressScreenState extends State<AddNewSearchAddressScreen> {
  final TextEditingController searchControlller = TextEditingController();
  late final SearchLocationBloc bloc;
  bool isTapUseCurrentLocation = false;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SearchLocationBloc>(context);
    bloc.add(SetInitialSearchLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.primary,
      resizeToAvoidBottomInset: false,
      appBar: SmCustomAppBar.searchBar(
        context: context,
        searchControllerText: searchControlller,
        onChangeSearch: onChangeSearch,
        onClear: () {
          searchSuggestion();
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 25,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView(
                children: [
                  if (searchControlller.text.isEmpty) ...[
                    SearchUseCurrentLocation(
                      onTap: getUserCurrentLocation,
                    ),
                  ],
                  AddNewSearchSuggestionBody(
                    searchController: searchControlller,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchSuggestion({String searchValue = ''}) {
    bloc.add(
      SearchSuggestionPlaceEvent(searchText: searchValue),
    );
    // temp fix
    setState(() => {});
  }

  void onChangeSearch(String? value) {
    EasyDebounce.debounce(
      'search-controller-google-suggestion',
      const Duration(milliseconds: 1000),
      () {
        final searchValue = searchControlller.text;
        searchControlller.text = searchValue;
        searchControlller.value = TextEditingValue(
          text: searchValue,
          selection: TextSelection.fromPosition(
            TextPosition(offset: searchValue.length),
          ),
        );
        searchSuggestion(searchValue: searchValue);
      },
    );
  }

  Future<void> getUserCurrentLocation({BuildContext? ctx}) async {
    final locationPermGranted = await AppPermission.locationPermission();
    if (locationPermGranted) {
      EasyLoading.show();
      final currentLocation = await getCurrentLocation();

      if (currentLocation != null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(currentLocation);
      }

      EasyLoading.dismiss();
      return;
    }
  }
}
