import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/cubit/path_finder/path_finder_cubit.dart';
import 'package:webspark_test/cubit/send_result/send_result_cubit.dart';
import 'package:webspark_test/cubit/url_checker/url_checker_cubit.dart';
import 'package:webspark_test/model/path_result.dart';
import 'package:webspark_test/screen/result.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key});

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  @override
  void initState() {
    context
        .read<PathFinderCubit>()
        .startFindPath(context.read<UrlCheckerCubit>().state.gridData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Process screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<PathFinderCubit, PathFinderState>(
          builder: (context, state) {
            var pathFinderCubit = context.read<PathFinderCubit>().state;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                const SizedBox(height: 16),
                Text(state.informMessage),
                const SizedBox(height: 16),
                Text('${state.processProgress.toStringAsFixed(2)}%'),
                const SizedBox(height: 16),
                SizedBox(
                  height: 120,
                  width: 120,
                  child: CircularProgressIndicator(
                    value: state.processProgress / 100,
                    color: Colors.blue,
                  ),
                ),
                const Spacer(),
                BlocConsumer<SendResultCubit, SendResultState>(
                  listener: (context, state) {
                    if (state.responseStatus == ResponseStatus.success) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ResultScreen(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: context
                                    .read<PathFinderCubit>()
                                    .state
                                    .calculatingFinish &&
                                !state.isLoading
                            ? () {
                                List<PathResult> resultData =
                                    pathFinderCubit.pathResult;

                                String url = context
                                    .read<UrlCheckerCubit>()
                                    .state
                                    .urlAPI;

                                context
                                    .read<SendResultCubit>()
                                    .sendResults(resultData, url);
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: state.isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.blue,
                              )
                            : const Text(
                                'Send result to server',
                                style: TextStyle(color: Colors.black),
                              ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}
