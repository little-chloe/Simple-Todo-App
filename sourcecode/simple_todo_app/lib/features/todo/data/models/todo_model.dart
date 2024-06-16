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

  @override
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
      TodoJsonKey.kDate: date != null ? date.toString() : 'null',
      TodoJsonKey.kTime:
          time != null ? '${time!.hour}:${time!.minute}' : 'null',
      TodoJsonKey.kCategory: category,
      TodoJsonKey.kIsDone: isDone.toString(),
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json[TodoJsonKey.kId],
      category: json[TodoJsonKey.kCategory],
      content: json[TodoJsonKey.kContent],
      createdAt: DateTime.parse(json[TodoJsonKey.kCreatedAt]),
      time: json[TodoJsonKey.kTime] != 'null'
          ? TimeOfDay(
              hour: int.parse(json[TodoJsonKey.kTime].split(':')[0]),
              minute: int.parse(
                json[TodoJsonKey.kTime].split(':')[1],
              ),
            )
          : null,
      date: json[TodoJsonKey.kDate] != 'null'
          ? DateTime.parse(json[TodoJsonKey.kDate])
          : null,
      isDone: bool.parse(json[TodoJsonKey.kIsDone]),
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
