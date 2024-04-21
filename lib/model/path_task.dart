import 'package:webspark_test/model/point.dart';

class PathTask {
  final String id;
  final List<List<String>> field;
  final Point start;
  final Point end;

  PathTask({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory PathTask.fromJson(Map<String, dynamic> json) {
    List<List<String>> parsedField = json['field'].map<List<String>>((row) => row.split('')).toList();

    return PathTask(
      id: json['id'],
      field: parsedField,
      start: Point.fromJson(json['start']),
      end: Point.fromJson(json['end']),
    );
  }
}
