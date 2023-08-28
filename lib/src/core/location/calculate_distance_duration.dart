import 'dart:convert';
import 'dart:io';

import 'package:fire_alert_mobile/src/core/config/app_constant.dart';
import 'package:fire_alert_mobile/src/core/location/models/destination.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<Destination> calculateDistanceKmMatrix({
  required LatLng origin,
  required List<LatLng> destinations,
}) async {
  const String baseUrl = 'maps.googleapis.com';
  const String distanceMatrix = 'maps/api/distancematrix/json';
  final client = http.Client();

  final params = {
    'mode': 'driving',
    'region': 'PH',
    'units': 'metric',
    'destinations': '${origin.latitude},${origin.longitude}',
    'origins':
        destinations.map((e) => '${e.latitude},${e.longitude}').join("|"),
    'key': AppConstant.googleApiKey,
  };

  final Uri url = Uri.https(baseUrl, distanceMatrix, params);

  print(url.toString());

  final response = await client.get(url);

  if (response.statusCode == HttpStatus.ok) {
    final responseBody = json.decode(response.body);

    if (responseBody['status'].toString().toLowerCase() == 'OK'.toLowerCase()) {
      final row = responseBody["rows"] as List;
      final List<double> distances = row.map((e) {
        final elements = e["elements"][0];
        final intKm = elements['distance']['value'] as int;
        final doubleKm = intKm / 1000;
        return double.parse(doubleKm.toStringAsFixed(2));
      }).toList();
      final List<double> durations = row.map((e) {
        final elements = e["elements"][0];
        final intSec = elements['duration']['value'] as int;
        final doubleMin = intSec / 60;
        return doubleMin;
      }).toList();

      return Destination(distances: distances, durations: durations);
    }
  }

  return const Destination(distances: [], durations: []);
}
