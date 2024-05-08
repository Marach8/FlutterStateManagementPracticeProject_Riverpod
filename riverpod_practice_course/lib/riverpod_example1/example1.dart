import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer(
          builder: (context, ref, child) {
            final dateTime = ref.watch(dateTimeProvider);
            final formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
            final formattedTime = DateFormat('hh:mm:ss a').format(dateTime);
            final sentence = "Today's date is $formattedDate and the time is $formattedTime";
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  sentence,
                  style: Theme.of(context).textTheme.headlineMedium
                ),
                MaterialButton(
                  onPressed: () => ref.read(dateTimeProvider.notifier).state = DateTime.now(),
                  child: const Text('Get Current Time'),
                ),
              ],
            );
          }
        ),
      )
    );
  }
}


final dateTimeProvider = StateProvider<DateTime>((_) => DateTime.now());