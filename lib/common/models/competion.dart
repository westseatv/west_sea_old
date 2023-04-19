// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'contender.dart';

class CompetionModel {
  final String id;
  final String name;
  final List<String> prizes;
  final String prize;
  final String desc;
  final String status;
  final int stake;
  final String endDate;
  final List<Contender> winners;
  final List<Contender> contenders;
  final List<Map<String, dynamic>> results;
  CompetionModel({
    required this.id,
    required this.name,
    required this.prizes,
    required this.prize,
    required this.desc,
    required this.status,
    required this.stake,
    required this.endDate,
    required this.winners,
    required this.contenders,
    required this.results,
  });

  CompetionModel copyWith({
    String? id,
    String? name,
    List<String>? prizes,
    String? prize,
    String? desc,
    String? status,
    int? stake,
    String? endDate,
    List<Contender>? winners,
    List<Contender>? contenders,
    List<Map<String, dynamic>>? results,
  }) {
    return CompetionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      prizes: prizes ?? this.prizes,
      prize: prize ?? this.prize,
      desc: desc ?? this.desc,
      status: status ?? this.status,
      stake: stake ?? this.stake,
      endDate: endDate ?? this.endDate,
      winners: winners ?? this.winners,
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
      'stake': stake,
      'endDate': endDate,
      'winners': winners.map((x) => x.toMap()).toList(),
      'contenders': contenders.map((x) => x.toMap()).toList(),
      'results': results,
    };
  }

  factory CompetionModel.fromMap(Map<String, dynamic> map) {
    return CompetionModel(
      id: map['id'] as String,
      name: map['name'] as String,
      prizes: List<String>.from(
        (map['prizes'] as List<String>),
      ),
      prize: map['prize'] as String,
      desc: map['desc'] as String,
      status: map['status'] as String,
      stake: map['stake'] as int,
      endDate: map['endDate'] as String,
      winners: List<Contender>.from(
        (map['winners'] as List<dynamic>).map<Contender>(
          (x) => Contender.fromMap(x as Map<String, dynamic>),
        ),
      ),
      contenders: List<Contender>.from(
        (map['contenders'] as List<dynamic>).map<Contender>(
          (x) => Contender.fromMap(x as Map<String, dynamic>),
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
    return 'CompetionModel(id: $id, name: $name, prizes: $prizes, prize: $prize, desc: $desc, status: $status, stake: $stake, endDate: $endDate, winners: $winners, contenders: $contenders, results: $results)';
  }

  @override
  bool operator ==(covariant CompetionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.prizes, prizes) &&
        other.prize == prize &&
        other.desc == desc &&
        other.status == status &&
        other.stake == stake &&
        other.endDate == endDate &&
        listEquals(other.winners, winners) &&
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
        stake.hashCode ^
        endDate.hashCode ^
        winners.hashCode ^
        contenders.hashCode ^
        results.hashCode;
  }

  String toJson() => json.encode(toMap());

  factory CompetionModel.fromJson(String source) =>
      CompetionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
