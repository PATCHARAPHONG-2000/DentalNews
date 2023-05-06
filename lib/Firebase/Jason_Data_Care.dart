// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Care_Data {
  final String data;
  final String name;
  final String image;
  final String image1;
  Care_Data({
    required this.data,
    required this.name,
    required this.image,
    required this.image1,
  });

  Care_Data copyWith({
    String? data,
    String? name,
    String? image,
    String? image1,
  }) {
    return Care_Data(
      data: data ?? this.data,
      name: name ?? this.name,
      image: image ?? this.image,
      image1: image1 ?? this.image1,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data,
      'name': name,
      'image': image,
      'image1': image1,
    };
  }

  factory Care_Data.fromMap(Map<String, dynamic> map) {
    return Care_Data(
      data: map['data'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      image1: map['image1'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Care_Data.fromJson(String source) =>
      Care_Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Care_Data(data: $data, name: $name, image: $image, image1: $image1)';
  }

  @override
  bool operator ==(covariant Care_Data other) {
    if (identical(this, other)) return true;

    return other.data == data &&
        other.name == name &&
        other.image == image &&
        other.image1 == image1;
  }

  @override
  int get hashCode {
    return data.hashCode ^ name.hashCode ^ image.hashCode ^ image1.hashCode;
  }
}
