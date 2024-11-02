import 'dart:convert';

class Toothache {
  final String id; // New id field to store Firestore document id
  final String author;
  final String content;
  final String imageUrl;
  final String name;
  final String time;

  Toothache({
    required this.id, // Include id in the constructor
    required this.author,
    required this.content,
    required this.imageUrl,
    required this.name,
    required this.time,
  });

  Toothache copyWith({
    String? id,
    String? author,
    String? content,
    String? imageUrl,
    String? name,
    String? time,
  }) {
    return Toothache(
      id: id ?? this.id, // Add id here as well
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

  factory Toothache.fromMap(String id, Map<String, dynamic> map) {
    return Toothache(
      id: id, // Set id here
      author: map['author'] as String,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String,
      name: map['name'] as String,
      time: map['time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Toothache.fromJson(String id, String source) =>
      Toothache.fromMap(id, json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Toothache(id: $id, author: $author, content: $content, imageUrl: $imageUrl, name: $name, time: $time)';
  }

  @override
  bool operator ==(covariant Toothache other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.author == author &&
        other.content == content &&
        other.imageUrl == imageUrl &&
        other.name == name &&
        other.time == time;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        author.hashCode ^
        content.hashCode ^
        imageUrl.hashCode ^
        name.hashCode ^
        time.hashCode;
  }
}
