// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class New_Knowledge {
  final String name;
  final String image;
  final String pdf;
  New_Knowledge({
    required this.name,
    required this.image,
    required this.pdf,
  });

  New_Knowledge copyWith({
    String? name,
    String? image,
    String? pdf,
  }) {
    return New_Knowledge(
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

  factory New_Knowledge.fromMap(Map<String, dynamic> map) {
    return New_Knowledge(
      name: map['name'] as String,
      image: map['image'] as String,
      pdf: map['pdf'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory New_Knowledge.fromJson(String source) =>
      New_Knowledge.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'New_Knowledge(name: $name, image: $image, pdf: $pdf)';

  @override
  bool operator ==(covariant New_Knowledge other) {
    if (identical(this, other)) return true;

    return other.name == name && other.image == image && other.pdf == pdf;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ pdf.hashCode;
}
