import 'package:flutter/foundation.dart';

class ResultModel {
  final String id;
  final List<String> results;
  final String date;
  ResultModel({
    required this.id,
    required this.results,
    required this.date,
  });

  ResultModel copyWith({
    String? id,
    List<String>? results,
    String? date,
  }) {
    return ResultModel(
      id: id ?? this.id,
      results: results ?? this.results,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'results': results,
      'date': date,
    };
  }

  factory ResultModel.fromMap(Map<String, dynamic> map) {
    return ResultModel(
      id: map['id'] as String,
      results: List<String>.from(
        (map['results'] as List<String>),
      ),
      date: map['date'] as String,
    );
  }

  @override
  String toString() => 'ResultModel(id: $id, results: $results, date: $date)';

  @override
  bool operator ==(covariant ResultModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.results, results) &&
        other.date == date;
  }

  @override
  int get hashCode => id.hashCode ^ results.hashCode ^ date.hashCode;
}

class ResultsListModel {
  List<ResultModel> resultsList;
  ResultsListModel({
    required this.resultsList,
  });

  ResultsListModel copyWith({
    List<ResultModel>? resultsList,
  }) {
    return ResultsListModel(
      resultsList: resultsList ?? this.resultsList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resultsList': resultsList.map((x) => x.toMap()).toList(),
    };
  }

  factory ResultsListModel.fromMap(Map<String, dynamic> map) {
    return ResultsListModel(
      resultsList: List<ResultModel>.from(
        (map['resultsList'] as List<dynamic>).map<ResultModel>(
          (x) => ResultModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toString() => 'ResultsLIstModel(resultsList: $resultsList)';

  @override
  bool operator ==(covariant ResultsListModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.resultsList, resultsList);
  }

  @override
  int get hashCode => resultsList.hashCode;
}
