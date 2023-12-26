import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_practice_course/riverpod_example5/changenotifier.dart';
import 'package:riverpod_practice_course/riverpod_example5/dialog.dart';


final personsProvider = ChangeNotifierProvider((_) => DataModel());

class Example5 extends ConsumerWidget {
  const Example5({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example5'), centerTitle: true),
      body: Consumer(
        builder: ((context, ref, child) {
          final dataModel = ref.watch(personsProvider);
          return ListView.builder(
            itemCount: dataModel.count,
            itemBuilder: (_, index){
              final person = dataModel.people.elementAt(index);
              return ListTile(
                title: GestureDetector(
                  onTap:() async{
                    final updatedPerson = await createOrUpdatePersonDialog(context, 'Update Person', person);
                    if(updatedPerson != null){dataModel.updatePerson(updatedPerson);}
                  },
                  child: Text(person.displayName)
                ),
              );
            }
          );
        })
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          final person = await createOrUpdatePersonDialog(context, 'Create Person');
          if(person != null){
            final dataModel = ref.read(personsProvider);
            dataModel.addPerson(person);
          }
        },
        child: const Icon(Icons.add)
      )
    );
  }
}
