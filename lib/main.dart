import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woof_route/bloc/whack_bloc.dart';
import 'package:woof_route/screens/welcome_whack.dart';
import 'package:woof_route/screens/whack_screen.dart';

void main() {
  runApp(BlocProvider(
    create: (_) => WhackBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quack-a-Duck',
      home: const StartScreen(),
    );
  }
}
