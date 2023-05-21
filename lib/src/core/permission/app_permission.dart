import 'package:permission_handler/permission_handler.dart';

class AppPermission {
  static Future<bool> cameraPermission() async {
    final permission = await Permission.camera.request();
    if (permission.isDenied || permission.isPermanentlyDenied) {
      return false;
    }
    return true;
  }

  static Future<bool> videoPermission() async {
    final permission = await Permission.videos.request();
    if (permission.isDenied || permission.isPermanentlyDenied) {
      return false;
    }
    return true;
  }

  static Future<bool> locationPermission() async {
    final permission = await Permission.location.request();
    if (permission.isDenied || permission.isPermanentlyDenied) {
      return false;
    }
    return true;
  }
}
