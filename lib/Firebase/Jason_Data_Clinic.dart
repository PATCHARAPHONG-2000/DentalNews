// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// ignore: camel_case_types
class Jason_PDF_Clinic {
  String address;
  String image;
  String image1;
  String name;
  String search;
  String time;
  String url;
  Jason_PDF_Clinic({
    required this.address,
    required this.image,
    required this.image1,
    required this.name,
    required this.search,
    required this.time,
    required this.url,
  });

  Jason_PDF_Clinic copyWith({
    String? address,
    String? image,
    String? image1,
    String? name,
    String? search,
    String? time,
    String? url,
  }) {
    return Jason_PDF_Clinic(
      address: address ?? this.address,
      image: image ?? this.image,
      image1: image1 ?? this.image1,
      name: name ?? this.name,
      search: search ?? this.search,
      time: time ?? this.time,
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
      'url': url,
    };
  }

  factory Jason_PDF_Clinic.fromMap(Map<String, dynamic> map) {
    return Jason_PDF_Clinic(
      address: map['address'] as String,
      image: map['image'] as String,
      image1: map['image1'] as String,
      name: map['name'] as String,
      search: map['search'] as String,
      time: map['time'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Jason_PDF_Clinic.fromJson(String source) =>
      Jason_PDF_Clinic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Jason_PDF_Clinic(address: $address, image: $image, image1: $image1, name: $name, search: $search, time: $time, url: $url)';
  }

  @override
  bool operator ==(covariant Jason_PDF_Clinic other) {
    if (identical(this, other)) return true;

    return other.address == address &&
        other.image == image &&
        other.image1 == image1 &&
        other.name == name &&
        other.search == search &&
        other.time == time &&
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
        url.hashCode;
  }
}
