import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice_course/riverpod_example1/example1.dart';
import 'package:riverpod_practice_course/riverpod_example2/example2.dart';
import 'package:riverpod_practice_course/riverpod_example3/example3.dart';
import 'package:riverpod_practice_course/riverpod_example4/example4.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.blue),
        useMaterial3: true
      ),
      home: const Example4()
    );
  }
}