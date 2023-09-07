import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_service_is_yours/bloc/bottom_bloc.dart';
import 'package:movie_service_is_yours/bloc/movie_bloc.dart';
import 'package:movie_service_is_yours/ui/initail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<MovieBloc>(create: (context) => MovieBloc()),
          BlocProvider<BottomBloc>(create: (context) => BottomBloc()..add(AppStarted())),
        ],
        child: const InitialPage(),
      ),
    );
  }
}
