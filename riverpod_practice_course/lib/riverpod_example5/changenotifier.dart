import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:riverpod_practice_course/riverpod_example5/person_class.dart';

class DataModel extends ChangeNotifier{
  final List<Person> _people = [];
  int get count => _people.length;
  UnmodifiableListView<Person> get people => UnmodifiableListView(_people);

  void addPerson(Person person) {
    _people.add(person);
    notifyListeners();
  }

  void removePerson(Person person) {
    _people.remove(person);
    notifyListeners();
  }

  void updatePerson(Person updatedPerson){
    final index = _people.indexOf(updatedPerson);
    final oldPerson = _people[index];
    if(oldPerson.name != updatedPerson.name || oldPerson.age !=  updatedPerson.age){
      _people[index] = oldPerson.updated(updatedPerson.name, updatedPerson.age);
      notifyListeners();
    }
  }
}
