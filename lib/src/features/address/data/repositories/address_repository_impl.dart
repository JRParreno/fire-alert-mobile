import 'package:dio/dio.dart';
import 'package:fire_alert_mobile/src/core/location/address_suggestion.dart';
import 'package:fire_alert_mobile/src/features/address/data/models/suggestion.dart';
import 'package:fire_alert_mobile/src/features/address/data/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  static Dio dio = Dio();

  @override
  Future<List<Suggestion>> fetchSuggestion(String search) async {
    final suggestions = await addressSuggestion(search);
    return suggestions;
  }
}
