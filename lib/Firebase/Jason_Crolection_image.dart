// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Crolection_Image {
  final String name;
  final String url;
  Crolection_Image({
    required this.name,
    required this.url,
  });

  Crolection_Image copyWith({
    String? name,
    String? url,
  }) {
    return Crolection_Image(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'url': url,
    };
  }

  factory Crolection_Image.fromMap(Map<String, dynamic> map) {
    return Crolection_Image(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Crolection_Image.fromJson(String source) =>
      Crolection_Image.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Crolection_Image(name: $name, url: $url)';

  @override
  bool operator ==(covariant Crolection_Image other) {
    if (identical(this, other)) return true;

    return other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
