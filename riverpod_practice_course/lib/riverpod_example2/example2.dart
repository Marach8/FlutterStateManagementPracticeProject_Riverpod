import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class Counter extends StateNotifier<int?>{
  Counter(): super(null);
  void increment() => state = state == null ? 1 : state! + 1;
  void decrement() => state = state == null ? 1 : state! - 1;
}


final counterProvider = StateNotifierProvider<Counter, int?>((_)
  => Counter()
);


class Example2 extends ConsumerWidget {
  const Example2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Consumer(
        builder: (BuildContext _, WidgetRef ref, Widget? __) {
          final count = ref.watch(counterProvider);
          return Text(count.toString());
        },
      ), 
      centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(            
            onLongPress: ref.read(counterProvider.notifier).decrement,
            onPressed: ref.read(counterProvider.notifier).increment,
            child: const Text('PressMe'),
          )
        ],
      )
    );
  }
}


// extension OptionalInfixAddition<T extends num> on T?{
//   T? operator +(T? other){
//     final shadow = this;
//     if(shadow != null){return shadow + (other ?? 0) as T;}
//     else{return null;}
//   }
// }