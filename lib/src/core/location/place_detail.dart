// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlaceDetail {
  final String formattedAddress;
  final double lat;
  final double lng;
  final String placeName;
  final String placeId;

  PlaceDetail({
    required this.formattedAddress,
    required this.lat,
    required this.lng,
    required this.placeName,
    required this.placeId,
  });

  PlaceDetail copyWith({
    String? formattedAddress,
    double? lat,
    double? lng,
    String? placeName,
    String? placeId,
  }) {
    return PlaceDetail(
      formattedAddress: formattedAddress ?? this.formattedAddress,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      placeName: placeName ?? this.placeName,
      placeId: placeId ?? this.placeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'formattedAddress': formattedAddress,
      'lat': lat,
      'lng': lng,
      'placeName': placeName,
      'placeId': placeId,
    };
  }

  factory PlaceDetail.fromMap(Map<String, dynamic> map) {
    return PlaceDetail(
      formattedAddress: map['formattedAddress'] as String,
      lat: map['lat'] as double,
      lng: map['lng'] as double,
      placeName: map['placeName'] as String,
      placeId: map['placeId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceDetail.fromJson(String source) =>
      PlaceDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlaceDetail(formattedAddress: $formattedAddress, lat: $lat, lng: $lng, placeName: $placeName, placeId: $placeId)';
  }

  @override
  bool operator ==(covariant PlaceDetail other) {
    if (identical(this, other)) return true;

    return other.formattedAddress == formattedAddress &&
        other.lat == lat &&
        other.lng == lng &&
        other.placeName == placeName &&
        other.placeId == placeId;
  }

  @override
  int get hashCode {
    return formattedAddress.hashCode ^
        lat.hashCode ^
        lng.hashCode ^
        placeName.hashCode ^
        placeId.hashCode;
  }
}
