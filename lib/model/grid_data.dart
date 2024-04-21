import 'package:webspark_test/model/point.dart';

class GridData {
  String id;
  List<List<String>> field;
  Point start;
  Point end;

  GridData(this.id, this.field, this.start, this.end);

  factory GridData.fromJson(Map<String, dynamic> json) {
    List<List<String>> field = (json['field'] as List<dynamic>).map((row) => (row as String).split('')).toList();
    return GridData(
      json['id'],
      field,
      Point.fromJson(json['start']),
      Point.fromJson(json['end']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field.map((row) => row.join('')).toList(),
      'start': start.toJson(),
      'end': end.toJson(),
    };
  }
}
