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

class TodoFailureState extends TodoState {
  final Failure failure;

  const TodoFailureState({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class TodoSuccessState extends TodoState {
  const TodoSuccessState();
}
