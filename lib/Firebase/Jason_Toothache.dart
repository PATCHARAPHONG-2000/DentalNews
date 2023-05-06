// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Toothache {
  final String data;
  final String image;
  final String name;
  Toothache({
    required this.data,
    required this.image,
    required this.name,
  });

  Toothache copyWith({
    String? data,
    String? image,
    String? name,
  }) {
    return Toothache(
      data: data ?? this.data,
      image: image ?? this.image,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data,
      'image': image,
      'name': name,
    };
  }

  factory Toothache.fromMap(Map<String, dynamic> map) {
    return Toothache(
      data: map['data'] as String,
      image: map['image'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Toothache.fromJson(String source) =>
      Toothache.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Toothache(data: $data, image: $image, name: $name)';

  @override
  bool operator ==(covariant Toothache other) {
    if (identical(this, other)) return true;

    return other.data == data && other.image == image && other.name == name;
  }

  @override
  int get hashCode => data.hashCode ^ image.hashCode ^ name.hashCode;
}
