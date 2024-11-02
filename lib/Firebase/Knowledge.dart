// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NewKnowledg {
  final String id; // เพิ่มฟิลด์ id
  final String name;
  final String author;
  final String time;
  final String coverUrl;
  final String pdfUrl;

  NewKnowledg({
    required this.id, // id เป็น required
    required this.name,
    required this.author,
    required this.time,
    required this.coverUrl,
    required this.pdfUrl,
  });

  NewKnowledg copyWith({
    String? id,
    String? name,
    String? author,
    String? time,
    String? coverUrl,
    String? pdfUrl,
  }) {
    return NewKnowledg(
      id: id ?? this.id, // ใช้ id ที่ส่งมา หรือ id เดิม
      name: name ?? this.name,
      author: author ?? this.author,
      time: time ?? this.time,
      coverUrl: coverUrl ?? this.coverUrl,
      pdfUrl: pdfUrl ?? this.pdfUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id, // เพิ่ม id ลงใน map
      'name': name,
      'author': author,
      'time': time,
      'coverUrl': coverUrl,
      'pdfUrl': pdfUrl,
    };
  }

  factory NewKnowledg.fromMap(Map<String, dynamic> map, String documentId) {
    return NewKnowledg(
      id: documentId, // ใช้ documentId จาก Firestore
      name: map['name'] as String,
      author: map['author'] as String,
      time: map['time'] as String,
      coverUrl: map['coverUrl'] as String,
      pdfUrl: map['pdfUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewKnowledg.fromJson(String source) =>
      NewKnowledg.fromMap(json.decode(source) as Map<String, dynamic>, '');

  @override
  String toString() {
    return 'NewKnowledg(id: $id, name: $name, author: $author, time: $time, coverUrl: $coverUrl, pdfUrl: $pdfUrl)';
  }

  @override
  bool operator ==(covariant NewKnowledg other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.author == author &&
        other.time == time &&
        other.coverUrl == coverUrl &&
        other.pdfUrl == pdfUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        author.hashCode ^
        time.hashCode ^
        coverUrl.hashCode ^
        pdfUrl.hashCode;
  }
}
