import 'package:fire_alert_mobile/src/core/location/place_detail.dart';
import 'package:fire_alert_mobile/src/core/service/google_service.dart';
import 'package:geolocator/geolocator.dart';

Future<PlaceDetail?> getCurrentLocation() async {
  PlaceDetail? currentLocation;
  final locationPermission = await Geolocator.checkPermission();

  if (locationPermission == LocationPermission.whileInUse ||
      locationPermission == LocationPermission.always) {
    final gpsLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );

    currentLocation = await GoogleService().getPlaceDetailsByLatLng(
      gpsLocation.latitude,
      gpsLocation.longitude,
    );
  } else if ((locationPermission == LocationPermission.denied ||
      locationPermission == LocationPermission.deniedForever)) {
    // Added fallback location if location perms not granted.

    // ** DO NOT RETURN NULL !!!
    // ** SINCE THIS "callBackPlaceDetail" FUNCTION DOES NOT CHECK CALLBACK VALUE
    currentLocation =
        await GoogleService().getPlaceDetailsByLatLng(14.5542574, 120.9889333);
  }

  return currentLocation;
}
