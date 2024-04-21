import 'dart:async';
import 'dart:isolate';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/model/grid.dart';
import 'package:webspark_test/model/grid_data.dart';
import 'package:webspark_test/model/path_result.dart';
import 'package:webspark_test/model/point.dart';
import 'package:webspark_test/utils/path_finder.dart';

part 'path_finder_state.dart';

class PathFinderCubit extends Cubit<PathFinderState> {
  PathFinderCubit() : super(PathFinderState.initial());

  void startFindPath(List<GridData> grids) async {
    final receivePort = ReceivePort();
    final completer = Completer<SendPort>();

    receivePort.listen((data) {
      if (data is SendPort) {
        completer.complete(data);
      } else if (data is List<PathResult>) {
        emit(PathFinderState(
          gridData: grids,
          pathResult: data,
          processProgress: 100,
        ));
        receivePort.close();
      } else if (data is double) {
        emit(PathFinderState(
          gridData: state.gridData,
          pathResult: state.pathResult,
          processProgress: data,
        ));
      }
    });

    await Isolate.spawn(_pathFinderIsolate, receivePort.sendPort);

    final sendPort = await completer.future;
    sendPort.send([grids, receivePort.sendPort]);
  }

  static void _pathFinderIsolate(SendPort sendPort) async {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);

    await for (final message in receivePort) {
      final grids = message[0] as List<GridData>;
      final responsePort = message[1] as SendPort;

      List<PathResult> results = [];
      int counter = 0;
      for (GridData gridData in grids) {
        counter++;
        Grid grid = Grid(gridData.field);
        PathFinder finder = PathFinder(grid);
        List<Point> path = finder.findPath(gridData.start, gridData.end);
        String formattedPath = path.map((p) => p.toString()).join('->');
        results
            .add(PathResult(id: gridData.id, steps: path, path: formattedPath));
        responsePort.send(counter * 100 / grids.length);
      }
      responsePort.send(results);
    }
  }
}
