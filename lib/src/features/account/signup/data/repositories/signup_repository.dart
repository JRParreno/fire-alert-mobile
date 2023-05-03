import 'package:fire_alert_mobile/src/features/account/signup/data/models/signup.dart';

abstract class SignupRepository {
  Future<Map<String, dynamic>?> register(Signup signup);
  Future<void> generateOTP(String userId);
}
