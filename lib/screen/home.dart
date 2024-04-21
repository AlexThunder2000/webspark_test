import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/cubit/url_checker/url_checker_cubit.dart';
import 'package:webspark_test/screen/process.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Home screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocConsumer<UrlCheckerCubit, UrlCheckerState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ProcessScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Set valid API URL in order to continue'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.swap_horiz),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            labelText: 'API URL',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.url,
                          onChanged: (url) {
                            context.read<UrlCheckerCubit>().enterURL(url);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.isError) Text(state.errorMessage),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isButtonAvailable
                        ? () {
                            context.read<UrlCheckerCubit>().saveAndTestURL();
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
                            'Start counting process',
                            style: TextStyle(color: Colors.black),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
