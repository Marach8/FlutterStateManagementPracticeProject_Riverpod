import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Example1 extends ConsumerWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final date = ref.watch(dateTimeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage'), centerTitle: true),
      body: Center(
        child: Text(
          date.toIso8601String(),
          style: Theme.of(context).textTheme.headlineMedium
        )
      )
    );
  }
}


final dateTimeProvider = Provider<DateTime>((_) => DateTime.now());