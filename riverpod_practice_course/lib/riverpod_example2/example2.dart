import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';


class DateTimeNotifier extends StateNotifier<DateTime>{
  late Timer _timer;

  DateTimeNotifier():super(DateTime.now()){
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => state = DateTime.now()
    );
  }

  @override 
  void dispose(){
    _timer.cancel();
    super.dispose();
  }
}


final dateTimeProvider = StateNotifierProvider<DateTimeNotifier, DateTime>(
  (_) => DateTimeNotifier()
);


class Example2 extends StatelessWidget {
  const Example2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (_, ref, __){
            final dateTime = ref.watch(dateTimeProvider);
            final formattedTime = DateFormat('hh:mm:ss a').format(dateTime);
            return Text(
              formattedTime,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10
              ),
            );
          }
        )
      ),

      body: Consumer(
        builder: (_, ref, __){
          final dateTime = ref.watch(dateTimeProvider);
          final formattedDate = DateFormat('dd/mm/yyyy').format(dateTime);

          return Center(
            child: Text(formattedDate),
          );
        }
      ),
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