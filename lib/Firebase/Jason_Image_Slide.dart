// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Image_Slide {
  String id;
  String image;

  Image_Slide({
    required this.id,
    required this.image,
  });

  Image_Slide copyWith({
    String? id,
    String? image,
  }) {
    return Image_Slide(
      id: id ?? this.id,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
    };
  }

  factory Image_Slide.fromMap(Map<String, dynamic> map) {
    return Image_Slide(
      id: map['id'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Image_Slide.fromJson(String source) =>
      Image_Slide.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Image_Slide(id: $id, image: $image)';

  @override
  bool operator ==(covariant Image_Slide other) {
    if (identical(this, other)) return true;

    return other.id == id && other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ image.hashCode;
}
