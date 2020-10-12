import 'package:QuitBuddy/models/smoke.dart';

class SmokeEntity {
  final String id;
  final DateTime date;
  final SmokeType smokeType;

  SmokeEntity(this.id, this.date, this.smokeType);

  @override
  int get hashCode => date.hashCode ^ id.hashCode ^ smokeType.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SmokeEntity && runtimeType == other.runtimeType && date == other.date && id == other.id && smokeType == other.smokeType;

  Map<String, Object> toJson() {
    return {
      'date': date,
      'id': id,
      'smokeType': smokeType.toString().split(".").last,
    };
  }

  @override
  String toString() {
    return 'SmokeEntity{date: $date, id: $id, smokeType: $smokeType}';
  }

  static SmokeEntity fromJson(Map<String, Object> json) {
    return SmokeEntity(
      json['id'] as String,
      json['date'] as DateTime,
      SmokeType.values.firstWhere((element) => element.toString() == "SmokeType." + json['smokeType']),
    );
  }
}
