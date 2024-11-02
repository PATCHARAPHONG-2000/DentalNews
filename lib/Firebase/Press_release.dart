import 'dart:convert';

class Pressrelease {
  final String id; // New id field
  final String author;
  final String coverImageUrl;
  final String date;
  final String pdfUrl;
  final String title;

  Pressrelease({
    required this.id, // Add id to the constructor
    required this.author,
    required this.coverImageUrl,
    required this.date,
    required this.pdfUrl,
    required this.title,
  });

  Pressrelease copyWith({
    String? id, // Add id to copyWith method
    String? author,
    String? coverImageUrl,
    String? date,
    String? pdfUrl,
    String? title,
  }) {
    return Pressrelease(
      id: id ?? this.id, // Include id in copyWith
      author: author ?? this.author,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      date: date ?? this.date,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id, // Include id in the map
      'author': author,
      'coverImageUrl': coverImageUrl,
      'date': date,
      'pdfUrl': pdfUrl,
      'title': title,
    };
  }

  factory Pressrelease.fromMap(String id, Map<String, dynamic> map) {
    return Pressrelease(
      id: id, // Pass id separately from the map
      author: map['author'] as String,
      coverImageUrl: map['coverImageUrl'] as String,
      date: map['date'] as String,
      pdfUrl: map['pdfUrl'] as String,
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pressrelease.fromJson(String id, String source) =>
      Pressrelease.fromMap(id, json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Pressrelease(id: $id, author: $author, coverImageUrl: $coverImageUrl, date: $date, pdfUrl: $pdfUrl, title: $title)';
  }

  @override
  bool operator ==(covariant Pressrelease other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.author == author &&
        other.coverImageUrl == coverImageUrl &&
        other.date == date &&
        other.pdfUrl == pdfUrl &&
        other.title == title;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        author.hashCode ^
        coverImageUrl.hashCode ^
        date.hashCode ^
        pdfUrl.hashCode ^
        title.hashCode;
  }
}
