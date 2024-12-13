import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClinicFirebase {
  final String name;
  final String address;
  final List<Map<String, dynamic>> workingDays; // ใช้ List<Map> สำหรับ workingDays
  final String map;

  ClinicFirebase({
    required this.name,
    required this.address,
    required this.workingDays,
    required this.map,
  });

  ClinicFirebase copyWith({
    String? address,
    String? name,
    List<Map<String, dynamic>>? workingDays,
    String? map,
  }) {
    return ClinicFirebase(
      address: address ?? this.address,
      name: name ?? this.name,
      workingDays: workingDays ?? this.workingDays,
      map: map ?? this.map,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'workingDays': workingDays,
      'map': map,
    };
  }

  factory ClinicFirebase.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ClinicFirebase(
      name: data['name'] ?? '',
      address: data['address'] ?? '',
      workingDays: data['workingDays'] != null
          ? List<Map<String, dynamic>>.from(data['workingDays'])
          : [],
      map: data['map'] ?? '',
    );
  }

  factory ClinicFirebase.fromMap(Map<String, dynamic> map) {
    return ClinicFirebase(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      workingDays: map['workingDays'] != null
          ? List<Map<String, dynamic>>.from(map['workingDays'])
          : [],
      map: map['map'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ClinicFirebase.fromJson(String source) =>
      ClinicFirebase.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClinicFirebase(address: $address, name: $name, workingDays: $workingDays, map: $map)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ClinicFirebase &&
        other.address == address &&
        other.name == name &&
        other.workingDays == workingDays &&
        other.map == map;
  }

  @override
  int get hashCode {
    return address.hashCode ^ name.hashCode ^ workingDays.hashCode ^ map.hashCode;
  }
}
