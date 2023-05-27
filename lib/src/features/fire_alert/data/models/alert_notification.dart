// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AlertNotification {
  final String pk;
  final String title;
  final String body;
  final bool isRejected;
  final bool isDone;
  final String address;
  AlertNotification({
    required this.pk,
    required this.title,
    required this.body,
    required this.isRejected,
    required this.isDone,
    required this.address,
  });

  AlertNotification copyWith({
    String? pk,
    String? title,
    String? body,
    bool? isRejected,
    bool? isDone,
    String? address,
  }) {
    return AlertNotification(
      pk: pk ?? this.pk,
      title: title ?? this.title,
      body: body ?? this.body,
      isRejected: isRejected ?? this.isRejected,
      isDone: isDone ?? this.isDone,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pk': pk,
      'title': title,
      'body': body,
      'isRejected': isRejected,
      'isDone': isDone,
      'address': address,
    };
  }

  factory AlertNotification.fromMap(Map<String, dynamic> map) {
    return AlertNotification(
      pk: map['pk'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
      isRejected: map['is_rejected'] as bool,
      isDone: map['is_done'] as bool,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AlertNotification.fromJson(String source) =>
      AlertNotification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AlertNotification(pk: $pk, title: $title, body: $body, isRejected: $isRejected, isDone: $isDone, address: $address)';
  }

  @override
  bool operator ==(covariant AlertNotification other) {
    if (identical(this, other)) return true;

    return other.pk == pk &&
        other.title == title &&
        other.body == body &&
        other.isRejected == isRejected &&
        other.isDone == isDone &&
        other.address == address;
  }

  @override
  int get hashCode {
    return pk.hashCode ^
        title.hashCode ^
        body.hashCode ^
        isRejected.hashCode ^
        isDone.hashCode ^
        address.hashCode;
  }
}
