import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicFirebase {
  final String name;
  final String address;
  final String time;
  final String holidays; // เพิ่มฟิลด์ holidays
  final String map; // เพิ่มฟิลด์ map

  ClinicFirebase({
    required this.name,
    required this.address,
    required this.time,
    required this.holidays, // เพิ่ม holidays
    required this.map, // เพิ่ม map
  });

  ClinicFirebase copyWith({
    String? address,
    String? name,
    String? holidays, // เพิ่ม holidays
    String? time,
    String? map, // เพิ่ม map
  }) {
    return ClinicFirebase(
      address: address ?? this.address,
      name: name ?? this.name,
      holidays: holidays ?? this.holidays, // เพิ่ม holidays
      time: time ?? this.time,
      map: map ?? this.map, // เพิ่ม map
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'name': name,
      'holidays': holidays, // เพิ่ม holidays
      'time': time,
      'map': map, // เพิ่ม map
    };
  }

  factory ClinicFirebase.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ClinicFirebase(
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      time: data['time'] ?? '',
      holidays: data['holidays'] ?? '', // เพิ่ม holidays
      map: data['map'] ?? '', // เพิ่ม map
    );
  }

  factory ClinicFirebase.fromMap(Map<String, dynamic> map) {
    return ClinicFirebase(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      time: map['time'] ?? '',
      holidays: map['holidays'] ?? '', // เพิ่ม holidays
      map: map['map'] ?? '', // เพิ่ม map
    );
  }

  String toJson() => json.encode(toMap());

  factory ClinicFirebase.fromJson(String source) =>
      ClinicFirebase.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClinicFirebase(address: $address, name: $name, holidays: $holidays, time: $time, map: $map)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClinicFirebase &&
        other.address == address &&
        other.name == name &&
        other.holidays == holidays && // เพิ่ม holidays
        other.time == time &&
        other.map == map; // เพิ่ม map
  }

  @override
  int get hashCode {
    return address.hashCode ^
        name.hashCode ^
        holidays.hashCode ^ // เพิ่ม holidays
        time.hashCode ^
        map.hashCode; // เพิ่ม map
  }
}
