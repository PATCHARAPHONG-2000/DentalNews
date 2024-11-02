// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CrolectionImage {
  final String name;
  final String url;
  CrolectionImage({
    required this.name,
    required this.url,
  });

  CrolectionImage copyWith({
    String? name,
    String? url,
  }) {
    return CrolectionImage(
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

  factory CrolectionImage.fromMap(Map<String, dynamic> map) {
    return CrolectionImage(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CrolectionImage.fromJson(String source) =>
      CrolectionImage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CrolectionImage(name: $name, url: $url)';

  @override
  bool operator ==(covariant CrolectionImage other) {
    if (identical(this, other)) return true;

    return other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
