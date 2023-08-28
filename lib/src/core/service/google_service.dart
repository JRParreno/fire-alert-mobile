import 'dart:convert';
import 'dart:io';

import 'package:fire_alert_mobile/src/core/config/app_constant.dart';
import 'package:fire_alert_mobile/src/core/location/place_detail.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class GoogleService {
  final String _baseUrl = 'maps.googleapis.com';
  final String _placeDetails = 'maps/api/place/details/json';
  final String _geoCodePath = 'maps/api/geocode/json';
  final String _apiKey = AppConstant.googleApiKey;

  final _client = http.Client();
  final _sessionToken = const Uuid().v1();

  Future<PlaceDetail?> getPlaceDetailsByLatLng(double lat, double lng) async {
    final client = http.Client();

    final params = {
      'latlng': '$lat,$lng',
      'key': _apiKey,
    };

    final Uri url = Uri.https(_baseUrl, _geoCodePath, params);

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
            lat: responseData['geometry']['location']['lat'],
            lng: responseData['geometry']['location']['lng'],
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

  Future<PlaceDetail?> getPlaceDetailsById(String placeId) async {
    final params = {
      'place_id': placeId,
      'fields':
          'formatted_address,geometry/location,place_id,name,address_components',
      'sessiontoken': _sessionToken,
      'key': _apiKey,
    };

    final Uri url = Uri.https(_baseUrl, _placeDetails, params);

    try {
      final response = await _client.get(url);
      if (response.statusCode == HttpStatus.ok) {
        final responseBody = json.decode(response.body);
        if (responseBody['status'] == 'OK') {
          final responseData = responseBody['result'];

          final placeDetail = PlaceDetail(
            formattedAddress: responseData['formatted_address'],
            lat: responseData['geometry']['location']['lat'],
            lng: responseData['geometry']['location']['lng'],
            placeId: responseData['place_id'],
            placeName: responseData['name'],
          );
          return placeDetail;
        }
        if (responseBody['status'] == 'ZERO_RESULTS') {
          return null;
        }
        if (responseBody['status'] == 'REQUEST_DENIED') {
          return null;
        }
      }
      return null;
    } catch (error) {
      return null;
    }
  }
}
