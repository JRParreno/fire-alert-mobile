import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fire_alert_mobile/src/core/config/app_constant.dart';
import 'package:fire_alert_mobile/src/core/interceptor/api_interceptor.dart';
import 'package:fire_alert_mobile/src/features/account/profile/data/models/fcm_token.dart';
import 'package:fire_alert_mobile/src/features/account/profile/data/models/profile.dart';
import 'package:fire_alert_mobile/src/features/account/profile/data/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  static Dio dio = Dio();

  @override
  Future<Profile> fetchProfile() async {
    const String url = '${AppConstant.apiUrl}/profile';
    return await ApiInterceptor.apiInstance().get(url).then((value) {
      final response = Profile.fromMap(value.data);
      return response;
    }).catchError((error) {
      throw error;
    }).onError((error, stackTrace) {
      throw error!;
    });
  }

  @override
  Future<Profile> updateProfile({required Profile profile}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<void> setPushToken(String token) async {
    const String url = '${AppConstant.serverUrl}/devices/';

    final data = {
      "registration_id": token,
      "type": Platform.isAndroid ? "android" : "ios"
    };

    await ApiInterceptor.apiInstance()
        .post(url, data: data)
        .onError((error, stackTrace) {
      throw error!;
    }).catchError((onError) {
      throw onError;
    });
  }
}
