import 'package:equatable/equatable.dart';
import 'package:simple_todo_app/core/failures/failure.dart';
import 'package:simple_todo_app/features/todo/domain/entities/todo_entity.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object?> get props => [];
}

class TodoLoadingState extends TodoState {
  const TodoLoadingState();
}

class TodoLoadingDoneState extends TodoState {
  final List<TodoEntity> todos;

  const TodoLoadingDoneState({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class TodoByCategoryLoadingDoneState extends TodoState {
  final List<TodoEntity> todos;

  const TodoByCategoryLoadingDoneState({required this.todos});

  @override
  List<Object?> get props => [todos];
}

class TodoFailureState extends TodoState {
  final Failure failure;

  const TodoFailureState({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class TodoCreateSuccessState extends TodoState {
  final TodoEntity todo;
  const TodoCreateSuccessState({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class TodoUpdateSuccessState extends TodoState {
  final TodoEntity todo;

  const TodoUpdateSuccessState({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class TodoDeleteSuccessState extends TodoState {
  final int id;

  const TodoDeleteSuccessState({required this.id});

  @override
  List<Object?> get props => [id];
}
