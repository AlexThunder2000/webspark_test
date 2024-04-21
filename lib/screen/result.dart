import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/cubit/path_finder/path_finder_cubit.dart';
import 'package:webspark_test/screen/preview.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Result list screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<PathFinderCubit, PathFinderState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.pathResult.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PreviewScreen(
                            gridData: state.gridData[index],
                            pathResult: state.pathResult[index],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Text(state.pathResult[index].path),
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
