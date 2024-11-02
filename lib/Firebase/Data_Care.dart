// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Care_Data {
  final String id;
  final String author;
  final String content;
  final String imageUrl;
  final String name;
  final String time;

  Care_Data({
    required this.id,
    required this.author,
    required this.content,
    required this.imageUrl,
    required this.name,
    required this.time,
  });

  Care_Data copyWith({
    String? author,
    String? content,
    String? imageUrl,
    String? name,
    String? time,
  }) {
    return Care_Data(
      id: id,
      author: author ?? this.author,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author': author,
      'content': content,
      'imageUrl': imageUrl,
      'name': name,
      'time': time,
    };
  }

  factory Care_Data.fromMap(String id, Map<String, dynamic> map) {
    return Care_Data(
      id: id, // The document ID
      author: map['author'] as String,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String,
      name: map['name'] as String,
      time: map['time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Care_Data.fromJson(String id, String source) =>
      Care_Data.fromMap(id, json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Care_Data( id: $id, author: $author, content: $content, imageUrl: $imageUrl, name: $name, time: $time)';
  }

  @override
  bool operator ==(covariant Care_Data other) {
    if (identical(this, other)) return true;

    return other.author == author &&
        other.id == id &&
        other.content == content &&
        other.imageUrl == imageUrl &&
        other.name == name &&
        other.time == time;
  }

  @override
  int get hashCode {
    return author.hashCode ^
        id.hashCode ^
        content.hashCode ^
        imageUrl.hashCode ^
        name.hashCode ^
        time.hashCode;
  }
}
