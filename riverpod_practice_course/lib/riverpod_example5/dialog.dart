import 'package:flutter/material.dart';
import 'package:riverpod_practice_course/riverpod_example5/person_class.dart';


final nameController = TextEditingController();
final ageController = TextEditingController();

Future<Person?> createOrUpdatePersonDialog(BuildContext context, String title, [Person? existingPerson]){
  var name = existingPerson?.name;
  var age = existingPerson?.age;
  return showDialog<Person?>(
    context: context, 
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Enter a name here...'),
            onChanged:(value) => name = value,
          ),
          TextField(
            controller: ageController,
            decoration: const InputDecoration(hintText: 'Enter an age here...'),
            onChanged:(value) =>  age = int.tryParse(value),
          )
        ]
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // ageController.clear();
            // nameController.clear();
          },
          child: const Text('Cancel')
        ),
        TextButton(
          onPressed: () {
            if(name != null && age != null){
              //Updating existingPerson
              if(existingPerson != null){
                final newPerson = existingPerson.updated(name, age);
                Navigator.of(context).pop(newPerson);
              } 
              //Create a new person
              else{Navigator.of(context).pop(Person(name: name!, age: age!));}
            }
            else{Navigator.pop(context);}
            // ageController.clear();
            // nameController.clear();
          },
          child: const Text('Save')
        )
      ]
    ),
  );
}
