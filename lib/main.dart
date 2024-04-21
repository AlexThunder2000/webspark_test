import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test/cubit/path_finder/path_finder_cubit.dart';
import 'package:webspark_test/cubit/send_result/send_result_cubit.dart';
import 'package:webspark_test/cubit/url_checker/url_checker_cubit.dart';
import 'package:webspark_test/screen/home.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UrlCheckerCubit(),
        ),
        BlocProvider(
          create: (context) => PathFinderCubit(),
        ),
        BlocProvider(
          create: (context) => SendResultCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
