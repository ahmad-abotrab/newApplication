import 'package:flutter/material.dart';

class Todo {
  String type;
  String titleTodo;
  String description;
  DateTime dateTodo;
  TimeOfDay timeOfDayTodo;

  Todo(
      {this.type,
      this.titleTodo,
      this.description,
      this.dateTodo,
      this.timeOfDayTodo});
}
