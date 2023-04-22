import 'package:flutter/foundation.dart';

class Recent {
  String name;
  String prize;
  List<String> prizes;
  String endDate;
  Recent({
    required this.name,
    required this.prize,
    required this.prizes,
    required this.endDate,
  });

  Recent copyWith({
    String? name,
    String? prize,
    List<String>? prizes,
    String? endDate,
  }) {
    return Recent(
      name: name ?? this.name,
      prize: prize ?? this.prize,
      prizes: prizes ?? this.prizes,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'prize': prize,
      'prizes': prizes,
      'endDate': endDate,
    };
  }

  factory Recent.fromMap(Map<String, dynamic> map) {
    return Recent(
      name: map['name'] as String,
      prize: map['prize'] as String,
      prizes: List<String>.from(
        (map['prizes']),
      ),
      endDate: map['endDate'] as String,
    );
  }

  @override
  String toString() {
    return 'Recent(name: $name, prize: $prize, prizes: $prizes, endDate: $endDate)';
  }

  @override
  bool operator ==(covariant Recent other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.prize == prize &&
        listEquals(other.prizes, prizes) &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return name.hashCode ^ prize.hashCode ^ prizes.hashCode ^ endDate.hashCode;
  }
}

class RecentList {
  List<Recent> recentList;
  RecentList({
    required this.recentList,
  });

  RecentList copyWith({
    List<Recent>? recentList,
  }) {
    return RecentList(
      recentList: recentList ?? this.recentList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recentList': recentList.map((x) => x.toMap()).toList(),
    };
  }

  factory RecentList.fromMap(Map<String, dynamic> map) {
    return RecentList(
      recentList: List<Recent>.from(
        (map['recentList'] as List<dynamic>).map<Recent>(
          (x) => Recent.fromMap(x),
        ),
      ),
    );
  }
  @override
  String toString() => 'RecentLIst(recentList: $recentList)';

  @override
  bool operator ==(covariant RecentList other) {
    if (identical(this, other)) return true;

    return listEquals(other.recentList, recentList);
  }

  @override
  int get hashCode => recentList.hashCode;
}
