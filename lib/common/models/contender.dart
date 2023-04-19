class Contender {
  final String id;
  final String name;
  final int points;
  final int w;
  final int p;
  Contender({
    required this.id,
    required this.name,
    required this.points,
    required this.w,
    required this.p,
  });

  Contender copyWith({
    String? id,
    String? name,
    int? points,
    int? w,
    int? p,
  }) {
    return Contender(
      id: id ?? this.id,
      name: name ?? this.name,
      points: points ?? this.points,
      w: w ?? this.w,
      p: p ?? this.p,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'points': points,
      'w': w,
      'p': p,
    };
  }

  factory Contender.fromMap(Map<String, dynamic> map) {
    return Contender(
      id: map['id'] as String,
      name: map['name'] as String,
      points: map['points'] as int,
      w: map['w'] as int,
      p: map['p'] as int,
    );
  }

  @override
  String toString() {
    return 'Contender(id: $id, name: $name, points: $points, w: $w, p: $p)';
  }

  @override
  bool operator ==(covariant Contender other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.points == points &&
        other.w == w &&
        other.p == p;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        points.hashCode ^
        w.hashCode ^
        p.hashCode;
  }
}
