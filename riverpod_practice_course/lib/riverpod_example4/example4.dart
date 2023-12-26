import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const names  = ['Emmanuel', 'David', 'Jeremiah', 'Jesse', 'Daniel', 'Nnanna', 'Greateness'];

final tickerProvider = StreamProvider((ref) => Stream.periodic(const Duration(seconds: 1), (i) => i + 1));
final namesProvider = StreamProvider((ref){
    return ref.watch(tickerProvider.future).asStream().map((count) => names.getRange(0, count));
  }
);



class Example4 extends ConsumerWidget {
  const Example4({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('StreamProvider Example'), centerTitle: true),
      body: names.when(
        data: (data) => ListView.builder(
          itemCount: data.length,
          itemBuilder: (_, listIndex){
            final name = data.elementAt(listIndex);
            return ListTile(title: Text(name));
          }
        ),
        error: (error, stack) {return Text('${error.toString()},');},
        loading: () => const Center(child: CircularProgressIndicator())
      )
    );
  }
}