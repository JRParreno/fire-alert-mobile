// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FireAlert {
  final String sender;
  final double longitude;
  final double latitude;
  final String incidentType;
  final String message;
  final String address;
  final double travelTime;
  final String? image;
  final String? video;
  final String? pk;
  final String? dateCreated;

  FireAlert({
    required this.sender,
    required this.longitude,
    required this.latitude,
    required this.incidentType,
    required this.message,
    required this.address,
    required this.travelTime,
    this.image,
    this.video,
    this.pk,
    this.dateCreated,
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
    String? address,
    double? travelTime,
    String? dateCreated,
  }) {
    return FireAlert(
      sender: sender ?? this.sender,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      incidentType: incidentType ?? this.incidentType,
      message: message ?? this.message,
      image: image ?? this.image,
      video: video ?? this.video,
      pk: pk ?? this.pk,
      address: address ?? this.address,
      travelTime: travelTime ?? this.travelTime,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender': sender,
      'longitude': longitude,
      'latitude': latitude,
      'incidentType': incidentType,
      'message': message,
      'image': image,
      'video': video,
      'pk': pk,
      'address': address,
      'travelTime': travelTime,
      'dateCreated': dateCreated,
    };
  }

  factory FireAlert.fromMap(Map<String, dynamic> map) {
    return FireAlert(
      sender: map['sender'].toString(),
      longitude: map['longitude'] as double,
      latitude: map['latitude'] as double,
      travelTime: map['travel_time'] as double,
      incidentType: map['incident_type'] as String,
      message: map['message'] as String,
      address: map['address'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      video: map['video'] != null ? map['video'] as String : null,
      pk: map['pk'] != null ? map['pk']!.toString() : null,
      dateCreated:
          map['date_created'] != null ? map['date_created']!.toString() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FireAlert.fromJson(String source) =>
      FireAlert.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FireAlert(sender: $sender, dateCreated: $dateCreated, longitude: $longitude, travelTime: $travelTime, latitude: $latitude, incidentType: $incidentType, message: $message, image: $image, video: $video, pk: $pk, address: $address)';
  }

  @override
  bool operator ==(covariant FireAlert other) {
    if (identical(this, other)) return true;

    return other.sender == sender &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        other.incidentType == incidentType &&
        other.travelTime == travelTime &&
        other.message == message &&
        other.image == image &&
        other.video == video &&
        other.address == address &&
        other.dateCreated == dateCreated &&
        other.pk == pk;
  }

  @override
  int get hashCode {
    return sender.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        incidentType.hashCode ^
        message.hashCode ^
        image.hashCode ^
        video.hashCode ^
        dateCreated.hashCode ^
        address.hashCode ^
        travelTime.hashCode ^
        pk.hashCode;
  }
}
