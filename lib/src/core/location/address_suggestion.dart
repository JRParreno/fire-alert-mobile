import 'dart:convert';
import 'dart:io';

import 'package:fire_alert_mobile/src/core/config/app_constant.dart';
import 'package:fire_alert_mobile/src/features/address/data/models/suggestion.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

Future<List<Suggestion>> addressSuggestion(String searchInpput) async {
  const String baseUrl = 'maps.googleapis.com';
  const String placeAutoComplete = 'maps/api/place/autocomplete/json';
  final client = http.Client();
  final sessionToken = const Uuid().v1();

  final params = {
    'input': searchInpput,
    'types': 'establishment|geocode',
    'components': 'country:ph',
    'language': 'en',
    'offset': '${searchInpput.length}',
    'sessiontoken': sessionToken,
    'key': AppConstant.googleApiKey,
  };

  final Uri url = Uri.https(baseUrl, placeAutoComplete, params);

  try {
    final response = await client.get(url);
    if (response.statusCode == HttpStatus.ok) {
      final responseBody = json.decode(response.body);
      if (responseBody['status'] == 'OK') {
        return responseBody['predictions']
            .map<Suggestion>((p) => Suggestion(
                  description: p['description'],
                  mainText: p['structured_formatting']['main_text'],
                  placeId: p['place_id'],
                  secondaryText: p['structured_formatting']['secondary_text'],
                ))
            .toList() as List<Suggestion>;
      }
      if (responseBody['status'] == 'ZERO_RESULTS') {
        return [];
      }
      if (responseBody['status'] == 'REQUEST_DENIED') {
        return [];
      }
    }
  } catch (error) {
    print(error.toString());
  }
  return [];
}
