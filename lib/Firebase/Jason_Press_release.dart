// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FireBase_Press_release {
  final String name;
  final String image;
  final String pdf;
  FireBase_Press_release({
    required this.name,
    required this.image,
    required this.pdf,
  });

  FireBase_Press_release copyWith({
    String? name,
    String? image,
    String? pdf,
  }) {
    return FireBase_Press_release(
      name: name ?? this.name,
      image: image ?? this.image,
      pdf: pdf ?? this.pdf,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'pdf': pdf,
    };
  }

  factory FireBase_Press_release.fromMap(Map<String, dynamic> map) {
    return FireBase_Press_release(
      name: map['name'] as String,
      image: map['image'] as String,
      pdf: map['pdf'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FireBase_Press_release.fromJson(String source) =>
      FireBase_Press_release.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FireBase_Press_release(name: $name, image: $image, pdf: $pdf)';

  @override
  bool operator ==(covariant FireBase_Press_release other) {
    if (identical(this, other)) return true;

    return other.name == name && other.image == image && other.pdf == pdf;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ pdf.hashCode;
}
