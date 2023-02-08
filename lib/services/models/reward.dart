// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RewardModel {
  String name;
  String? value;
  int cost;
  String? desc;
  int isClaimed;
  RewardModel({
    required this.name,
    this.value,
    required this.cost,
    this.desc,
    required this.isClaimed,
  });

  RewardModel copyWith({
    String? name,
    String? value,
    int? cost,
    String? desc,
    int? isClaimed,
  }) {
    return RewardModel(
      name: name ?? this.name,
      value: value ?? this.value,
      cost: cost ?? this.cost,
      desc: desc ?? this.desc,
      isClaimed: isClaimed ?? this.isClaimed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'value': value,
      'cost': cost,
      'desc': desc,
      'isClaimed': isClaimed,
    };
  }

  factory RewardModel.fromMap(Map<String, dynamic> map) {
    return RewardModel(
      name: map['name'] as String,
      value: map['value'] != null ? map['value'] as String : null,
      cost: map['cost'] as int,
      desc: map['desc'] != null ? map['desc'] as String : null,
      isClaimed: map['isClaimed'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RewardModel.fromJson(String source) =>
      RewardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RewardModel(name: $name, value: $value, cost: $cost, desc: $desc, isClaimed: $isClaimed)';
  }

  @override
  bool operator ==(covariant RewardModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.value == value &&
        other.cost == cost &&
        other.desc == desc &&
        other.isClaimed == isClaimed;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        value.hashCode ^
        cost.hashCode ^
        desc.hashCode ^
        isClaimed.hashCode;
  }
}
