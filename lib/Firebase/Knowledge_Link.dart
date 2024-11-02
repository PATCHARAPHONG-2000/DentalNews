// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Know_Link {
  final String name;
  final String url;
  Know_Link({
    required this.name,
    required this.url,
  });

  Know_Link copyWith({
    String? name,
    String? url,
  }) {
    return Know_Link(
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

  factory Know_Link.fromMap(Map<String, dynamic> map) {
    return Know_Link(
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Know_Link.fromJson(String source) =>
      Know_Link.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Know_Link(name: $name, url: $url)';

  @override
  bool operator ==(covariant Know_Link other) {
    if (identical(this, other)) return true;

    return other.name == name && other.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
