import 'package:fire_alert_mobile/src/features/fire_alert/data/models/fire_alert.dart';

abstract class FireAlertRepository {
  Future<FireAlert> sendFireAlert(FireAlert alert);
  Future<FireAlert?> fetchCurrentFireAlert();
}
