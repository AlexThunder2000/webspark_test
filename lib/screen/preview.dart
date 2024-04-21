import 'package:flutter/material.dart';
import 'package:webspark_test/model/grid_data.dart';
import 'package:webspark_test/model/path_result.dart';
import 'package:webspark_test/model/point.dart';

class PreviewScreen extends StatelessWidget {
  final GridData gridData;
  final PathResult pathResult;
  const PreviewScreen(
      {super.key, required this.gridData, required this.pathResult});

  @override
  Widget build(BuildContext context) {
    final pathPoints = Set<Point>.from(pathResult.steps);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Result list screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridData.field[0].length,
        ),
        itemCount: gridData.field.length * gridData.field[0].length,
        itemBuilder: (BuildContext context, int index) {
          var y = index ~/ gridData.field[0].length;
          var x = index % gridData.field[0].length;

          var cell = gridData.field[y][x];
          Color cellColor = _getColorForCell(x, y, cell, pathPoints, gridData);
          Color textColor = _getColorForText(x, y, cell, pathPoints, gridData);
          return GridTile(
            child: Container(
              decoration: BoxDecoration(
                color: cellColor,
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(
                  '($x,$y)',
                  style: TextStyle(color: textColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getColorForCell(
      int x, int y, String cell, Set<Point> pathPoints, GridData gridData) {
    if (Point(x, y) == gridData.start) {
      return const Color(0xFF64FFDA);
    }
    if (Point(x, y) == gridData.end) {
      return const Color(0xFF009688);
    }
    if (cell == 'X') return const Color(0xFF000000);
    if (pathPoints.contains(Point(x, y))) {
      return const Color(0xFF4CAF50);
    }
    return const Color(0xFFFFFFFF);
  }

  Color _getColorForText(
      int x, int y, String cell, Set<Point> pathPoints, GridData gridData) {
    if (cell == 'X') {
      return const Color(0xFFFFFFFF);
    } else {
      return const Color(0xFF000000);
    }
  }
}
