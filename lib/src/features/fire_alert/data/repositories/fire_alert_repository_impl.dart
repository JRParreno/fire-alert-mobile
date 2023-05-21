import 'package:dio/dio.dart';
import 'package:fire_alert_mobile/src/core/config/app_constant.dart';
import 'package:fire_alert_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/data/models/fire_alert.dart';
import 'package:fire_alert_mobile/src/features/fire_alert/data/repositories/fire_alert_repository.dart';

class FireAlertRepositoryImpl extends FireAlertRepository {
  final Dio dio = Dio();
  final formData = FormData();

  @override
  Future<FireAlert> sendFireAlert(FireAlert alert) async {
    const String url = '${AppConstant.apiUrl}/fire-guard';
    DateTime dateToday = DateTime.now();

    final data = FormData.fromMap(
      {
        "sender": int.parse(alert.sender),
        "google_map_url": alert.googleMapUrl,
        "message": alert.message,
        "longitude": alert.longitude,
        "latitude": alert.latitude,
        "incident_type": alert.incidentType,
        "image": alert.image != null
            ? await MultipartFile.fromFile(alert.image!,
                filename: '$dateToday - ${alert.image!.split('/').last}')
            : null,
        "video": alert.video != null
            ? await MultipartFile.fromFile(alert.video!,
                filename: '$dateToday - ${alert.video!.split('/').last}')
            : null,
      },
    );

    return await ApiInterceptor.apiInstance()
        .post(url,
            data: data,
            options: Options(
              contentType: "multipart/form-data",
            ))
        .then((value) {
      final response = FireAlert.fromMap(value.data);
      return response;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }
}
