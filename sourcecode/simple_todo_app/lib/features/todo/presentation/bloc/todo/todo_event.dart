import 'package:equatable/equatable.dart';
import 'package:simple_todo_app/features/todo/domain/entities/todo_entity.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class CreateTodoEvent extends TodoEvent {
  final TodoEntity todo;

  const CreateTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class UpdateTodoEvent extends TodoEvent {
  final TodoEntity todo;

  const UpdateTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class DeleteTodoEvent extends TodoEvent {
  final int id;

  const DeleteTodoEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetAllTodosEvent extends TodoEvent {
  const GetAllTodosEvent();
}
