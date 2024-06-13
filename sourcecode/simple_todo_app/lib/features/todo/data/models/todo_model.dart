import 'package:flutter/material.dart';
import 'package:simple_todo_app/core/constants/todo_json_key.dart';
import 'package:simple_todo_app/features/todo/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel({
    super.category,
    super.isDone,
    super.id,
    super.content,
    super.createdAt,
    super.date,
    super.time,
  });

  TodoModel copyWith({
    String? newCategory,
    bool? newIsDone,
    int? newId,
    String? newContent,
    DateTime? newDate,
    TimeOfDay? newTime,
  }) {
    return TodoModel(
      category: newCategory ?? category,
      isDone: newIsDone ?? isDone,
      id: newId ?? id,
      content: newContent ?? content,
      createdAt: createdAt,
      date: newDate ?? date,
      time: newTime ?? time,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      TodoJsonKey.kId: id,
      TodoJsonKey.kContent: content,
      TodoJsonKey.kCreatedAt: createdAt.toString(),
      TodoJsonKey.kDate: date.toString(),
      TodoJsonKey.kTime: time.toString(),
      TodoJsonKey.kCategory: category,
      TodoJsonKey.kIsDone: isDone,
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json[TodoJsonKey.kId],
      content: json[TodoJsonKey.kContent],
      createdAt: DateTime.parse(json[TodoJsonKey.kCreatedAt]),
      date: DateTime.parse(json[TodoJsonKey.kDate]),
      time: TimeOfDay(
        hour: int.parse(json[TodoJsonKey.kTime].split(':')[0]),
        minute: int.parse(
          json[TodoJsonKey.kTime].split(':')[1],
        ),
      ),
      category: json[TodoJsonKey.kCategory],
      isDone: json[TodoJsonKey.kIsDone],
    );
  }

  factory TodoModel.fromEntity(TodoEntity todo) {
    return TodoModel(
      isDone: todo.isDone,
      category: todo.category,
      id: todo.id,
      content: todo.content,
      createdAt: todo.createdAt,
      date: todo.date,
      time: todo.time,
    );
  }
}
