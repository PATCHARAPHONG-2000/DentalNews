// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Clinic {
  final String address;
  final String image;
  final String image1;
  final String name;
  final String search;
  final String time;
  final String time_out;
  final String url;
  Clinic({
    required this.address,
    required this.image,
    required this.image1,
    required this.name,
    required this.search,
    required this.time,
    required this.time_out,
    required this.url,
  });

  Clinic copyWith({
    String? address,
    String? image,
    String? image1,
    String? name,
    String? search,
    String? time,
    String? time_out,
    String? url,
  }) {
    return Clinic(
      address: address ?? this.address,
      image: image ?? this.image,
      image1: image1 ?? this.image1,
      name: name ?? this.name,
      search: search ?? this.search,
      time: time ?? this.time,
      time_out: time_out ?? this.time_out,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'image': image,
      'image1': image1,
      'name': name,
      'search': search,
      'time': time,
      'time_out': time_out,
      'url': url,
    };
  }

  factory Clinic.fromMap(Map<String, dynamic> map) {
    return Clinic(
      address: map['address'] as String,
      image: map['image'] as String,
      image1: map['image1'] as String,
      name: map['name'] as String,
      search: map['search'] as String,
      time: map['time'] as String,
      time_out: map['time_out'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Clinic.fromJson(String source) =>
      Clinic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Clinic(address: $address, image: $image, image1: $image1, name: $name, search: $search, time: $time, time_out: $time_out, url: $url)';
  }

  @override
  bool operator ==(covariant Clinic other) {
    if (identical(this, other)) return true;

    return other.address == address &&
        other.image == image &&
        other.image1 == image1 &&
        other.name == name &&
        other.search == search &&
        other.time == time &&
        other.time_out == time_out &&
        other.url == url;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        image.hashCode ^
        image1.hashCode ^
        name.hashCode ^
        search.hashCode ^
        time.hashCode ^
        time_out.hashCode ^
        url.hashCode;
  }
}
