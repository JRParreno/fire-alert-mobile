import 'package:fire_alert_mobile/src/core/config/app_constant.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UrlLauncherGoogleMap {
  static Future<void> openMap(double latitude, double longitude) async {
    final test = await MapLauncher.isMapAvailable(MapType.google);
    if (test != null && test) {
      await MapLauncher.showDirections(
        mapType: MapType.google,
        destination: Coords(latitude, longitude),
        destinationTitle: "Current Position",
        origin: AppConstant.fireStation,
        directionsMode: DirectionsMode.driving,
        originTitle: "Fire Station",
      );
    }
  }

  static void openGoogleMapLink(String url) async {
    final checkUrl = await canLaunchUrlString(url);

    if (checkUrl) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } else {
      // print("Something went wrong");
    }
  }

  static String? getUrlMap(String text) {
    RegExp exp = RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    Iterable<RegExpMatch> urlMatches = exp.allMatches(text);
    List<String> urls = urlMatches
        .map((urlMatch) => text.substring(urlMatch.start, urlMatch.end))
        .toList();

    return urls.isNotEmpty ? urls.first.toString() : null;
  }
}
