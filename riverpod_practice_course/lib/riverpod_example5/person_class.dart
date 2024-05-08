import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

@immutable 
class Person{
  final String name; 
  final int age;
  final String id;

  Person({
    required this.name,
    required this.age,
    String? uuid
  }): id = uuid ?? const Uuid().v4();

  Person updated([String? name, int? age]) 
    => Person(
      name: name ?? this.name,
      age: age ?? this.age,
      uuid: id
    );

  String get displayName => '$name ($age years old)';

  @override 
  bool operator ==(covariant Person other) => id == other.id;

  @override 
  int get hashCode => id.hashCode;

  @override 
  String toString() => ('Person(name: $name, age: $age, id: $id)');
}
