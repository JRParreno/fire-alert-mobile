import 'dart:convert';
import 'dart:io';

import 'package:fire_alert_mobile/src/core/config/app_constant.dart';
import 'package:fire_alert_mobile/src/core/location/place_detail.dart';
import 'package:http/http.dart' as http;

class GoogleService {
  static Future<PlaceDetail?> getPlaceDetailsByLatLng(
      double lat, double lng) async {
    const String apiKey = AppConstant.googleApiKey;
    const String baseUrl = 'maps.googleapis.com';
    const String geoCodePath = 'maps/api/geocode/json';

    final client = http.Client();

    final params = {
      'latlng': '$lat,$lng',
      'key': apiKey,
    };

    final Uri url = Uri.https(baseUrl, geoCodePath, params);

    try {
      final response = await client.get(url);
      if (response.statusCode == HttpStatus.ok) {
        final responseBody = json.decode(response.body);

        if (responseBody['status'].toString().toLowerCase() ==
            'OK'.toLowerCase()) {
          final responseData = responseBody['results'][0];
          final placeNameArr =
              "${responseData['formatted_address']}".split(",");

          return PlaceDetail(
            formattedAddress: responseData['formatted_address'],
            placeId: responseData['place_id'],
            placeName: "${placeNameArr[0]},${placeNameArr[1]}",
            lat: responseData['latitude'],
            lng: responseData['longitude'],
          );
        }

        if (responseBody['status'] == 'ZERO_RESULTS') {
          return null;
        }
        if (responseBody['status'] == 'REQUEST_DENIED') {
          return null;
        }
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
}
