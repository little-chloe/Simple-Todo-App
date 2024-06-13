import 'package:flutter/material.dart';

class TodoEntity {
  final int? id;
  final String? category;
  final String? content;
  final DateTime? createdAt;
  final TimeOfDay? time;
  final DateTime? date;
  final bool? isDone;

  const TodoEntity({
    this.category,
    this.isDone,
    this.id,
    this.content,
    this.createdAt,
    this.date,
    this.time,
  });
}
