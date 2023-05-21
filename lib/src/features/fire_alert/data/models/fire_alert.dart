// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FireAlert {
  final String sender;
  final String googleMapUrl;
  final double longitude;
  final double latitude;
  final String incidentType;
  final String message;
  final String? image;
  final String? video;
  final String? pk;

  FireAlert({
    required this.sender,
    required this.googleMapUrl,
    required this.longitude,
    required this.latitude,
    required this.incidentType,
    required this.message,
    this.image,
    this.video,
    this.pk,
  });

  FireAlert copyWith({
    String? sender,
    String? googleMapUrl,
    double? longitude,
    double? latitude,
    String? incidentType,
    String? message,
    String? image,
    String? video,
    String? pk,
  }) {
    return FireAlert(
      sender: sender ?? this.sender,
      googleMapUrl: googleMapUrl ?? this.googleMapUrl,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      incidentType: incidentType ?? this.incidentType,
      message: message ?? this.message,
      image: image ?? this.image,
      video: video ?? this.video,
      pk: pk ?? this.pk,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'googleMapUrl': googleMapUrl,
      'longitude': longitude,
      'latitude': latitude,
      'incidentType': incidentType,
      'message': message,
      'image': image,
      'video': video,
      'pk': pk,
    };
  }

  factory FireAlert.fromMap(Map<String, dynamic> map) {
    return FireAlert(
      sender: map['sender'].toString(),
      googleMapUrl: map['google_map_url'] as String,
      longitude: map['longitude'] as double,
      latitude: map['latitude'] as double,
      incidentType: map['incident_type'] as String,
      message: map['message'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      video: map['video'] != null ? map['video'] as String : null,
      pk: map['pk'] != null ? map['pk']!.toString() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FireAlert.fromJson(String source) =>
      FireAlert.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FireAlert(sender: $sender, googleMapUrl: $googleMapUrl, longitude: $longitude, latitude: $latitude, incidentType: $incidentType, message: $message, image: $image, video: $video, pk: $pk)';
  }

  @override
  bool operator ==(covariant FireAlert other) {
    if (identical(this, other)) return true;

    return other.sender == sender &&
        other.googleMapUrl == googleMapUrl &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.incidentType == incidentType &&
        other.message == message &&
        other.image == image &&
        other.video == video &&
        other.pk == pk;
  }

  @override
  int get hashCode {
    return sender.hashCode ^
        googleMapUrl.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        incidentType.hashCode ^
        message.hashCode ^
        image.hashCode ^
        video.hashCode ^
        pk.hashCode;
  }
}
