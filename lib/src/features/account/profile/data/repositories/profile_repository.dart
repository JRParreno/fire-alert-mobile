import 'package:fire_alert_mobile/src/features/account/profile/data/models/profile.dart';

abstract class ProfileRepository {
  Future<Profile> fetchProfile();
  Future<Profile> updateProfile({
    required Profile profile,
  });
  Future<void> setPushToken(String token);
}
