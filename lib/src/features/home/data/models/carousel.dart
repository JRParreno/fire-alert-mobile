// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Carousel {
  final String imageUrl;

  Carousel({
    required this.imageUrl,
  });

  Carousel copyWith({
    String? imageUrl,
  }) {
    return Carousel(
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
    };
  }

  factory Carousel.fromMap(Map<String, dynamic> map) {
    return Carousel(
      imageUrl: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Carousel.fromJson(String source) =>
      Carousel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Carousel(imageUrl: $imageUrl)';

  @override
  bool operator ==(covariant Carousel other) {
    if (identical(this, other)) return true;

    return other.imageUrl == imageUrl;
  }

  @override
  int get hashCode => imageUrl.hashCode;
}
