import 'package:flutter/foundation.dart';

class CommunityModel {
  final String id;
  final String name;
  final String banner;
  final String avater;
  final List<String> members;
  final List<String> mods;
  CommunityModel({
    required this.id,
    required this.name,
    required this.banner,
    required this.avater,
    required this.members,
    required this.mods,
  });

  CommunityModel copyWith({
    String? id,
    String? name,
    String? banner,
    String? avater,
    List<String>? members,
    List<String>? mods,
  }) {
    return CommunityModel(
      id: id ?? this.id,
      name: name ?? this.name,
      banner: banner ?? this.banner,
      avater: avater ?? this.avater,
      members: members ?? this.members,
      mods: mods ?? this.mods,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'banner': banner});
    result.addAll({'avater': avater});
    result.addAll({'members': members});
    result.addAll({'mods': mods});
  
    return result;
  }

  factory CommunityModel.fromMap(Map<String, dynamic> map) {
    return CommunityModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      banner: map['banner'] ?? '',
      avater: map['avater'] ?? '',
      members: List<String>.from(map['members']),
      mods: List<String>.from(map['mods']),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory CommunityModel.fromJson(String source) => CommunityModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CommunityModel(id: $id, name: $name, banner: $banner, avater: $avater, members: $members, mods: $mods)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CommunityModel &&
      other.id == id &&
      other.name == name &&
      other.banner == banner &&
      other.avater == avater &&
      listEquals(other.members, members) &&
      listEquals(other.mods, mods);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      banner.hashCode ^
      avater.hashCode ^
      members.hashCode ^
      mods.hashCode;
  }
}
