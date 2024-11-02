// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore: camel_case_types
class Image_Slide {
  String image;

  Image_Slide({
    required this.image,
  });

  Image_Slide copyWith({
    String? id,
    String? image,
  }) {
    return Image_Slide(
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
    };
  }

  factory Image_Slide.fromMap(Map<String, dynamic> map) {
    return Image_Slide(
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Image_Slide.fromJson(String source) =>
      Image_Slide.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Image_Slide( image: $image)';

  @override
  bool operator ==(covariant Image_Slide other) {
    if (identical(this, other)) return true;

    return other.image == image;
  }

  @override
  int get hashCode => image.hashCode;
}
