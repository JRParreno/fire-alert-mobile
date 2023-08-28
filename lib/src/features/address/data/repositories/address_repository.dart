import 'package:fire_alert_mobile/src/features/address/data/models/suggestion.dart';

abstract class AddressRepository {
  Future<List<Suggestion>> fetchSuggestion(String search);
}
