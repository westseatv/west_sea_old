import 'package:flutter/foundation.dart';

import 'contender.dart';

class CompetitionModel {
  final String id;
  final String name;
  final List<String> prizes;
  final String prize;
  final String desc;
  String status;
  final String endDate;
  final List<Contender> contenders;
  final List<Map<String, dynamic>> results;
  CompetitionModel({
    required this.id,
    required this.name,
    required this.prizes,
    required this.prize,
    required this.desc,
    required this.status,
    required this.endDate,
    required this.contenders,
    required this.results,
  });

  CompetitionModel copyWith({
    String? id,
    String? name,
    List<String>? prizes,
    String? prize,
    String? desc,
    String? status,
    String? endDate,
    List<Contender>? contenders,
    List<Map<String, dynamic>>? results,
  }) {
    return CompetitionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      prizes: prizes ?? this.prizes,
      prize: prize ?? this.prize,
      desc: desc ?? this.desc,
      status: status ?? this.status,
      endDate: endDate ?? this.endDate,
      contenders: contenders ?? this.contenders,
      results: results ?? this.results,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'prizes': prizes,
      'prize': prize,
      'desc': desc,
      'status': status,
      'endDate': endDate,
      'contenders': contenders.map((x) => x.toMap()).toList(),
      'results': results,
    };
  }

  factory CompetitionModel.fromMap(Map<String, dynamic> map) {
    return CompetitionModel(
      id: map['id'] as String,
      name: map['name'] as String,
      prizes: List<String>.from(
        (map['prizes']),
      ),
      prize: map['prize'] as String,
      desc: map['desc'] as String,
      status: map['status'] as String,
      endDate: map['endDate'] as String,
      contenders: List<Contender>.from(
        (map['contenders'] as List<dynamic>).map<Contender>(
          (x) => Contender.fromMap(x),
        ),
      ),
      results: List<Map<String, dynamic>>.from(
        (map['results'] as List<dynamic>).map<Map<String, dynamic>>(
          (x) => x,
        ),
      ),
    );
  }

  @override
  String toString() {
    return 'CompetionModel(id: $id, name: $name, prizes: $prizes, prize: $prize, desc: $desc, status: $status, endDate: $endDate,contenders: $contenders, results: $results)';
  }

  @override
  bool operator ==(covariant CompetitionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.prizes, prizes) &&
        other.prize == prize &&
        other.desc == desc &&
        other.status == status &&
        other.endDate == endDate &&
        listEquals(other.contenders, contenders) &&
        listEquals(other.results, results);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        prizes.hashCode ^
        prize.hashCode ^
        desc.hashCode ^
        status.hashCode ^
        endDate.hashCode ^
        contenders.hashCode ^
        results.hashCode;
  }
}
