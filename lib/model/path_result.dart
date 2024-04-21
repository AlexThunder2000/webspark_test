import 'package:webspark_test/model/point.dart';

class PathResult {
  String id;
  List<Point> steps;
  String path;

  PathResult({required this.id, required this.steps, required this.path});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'result': {
        'steps': steps.map((p) => p.toJson()).toList(),
        'path': path,
      },
    };
  }
}
