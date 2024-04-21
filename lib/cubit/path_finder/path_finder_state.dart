part of 'path_finder_cubit.dart';

class PathFinderState {
  final double processProgress;
  final List<GridData> gridData;
  final List<PathResult> pathResult;

  const PathFinderState({
    required this.gridData,
    required this.pathResult,
    required this.processProgress,
  });

  PathFinderState.initial()
      : gridData = [],
        processProgress = 0,
        pathResult = [];

  String get informMessage {
    if (calculatingFinish) {
      return 'All calculations has finished, you can send your results to server';
    } else {
      return 'Calculating...';
    }
  }

  bool get calculatingFinish => processProgress == 100;
}
