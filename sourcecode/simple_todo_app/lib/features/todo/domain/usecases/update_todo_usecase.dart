import 'package:dartz/dartz.dart';
import 'package:simple_todo_app/core/failures/failure.dart';
import 'package:simple_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:simple_todo_app/features/todo/domain/repositories/todo_repository.dart';

class UpdateTodoUsecase {
  final TodoRepository todoRepository;

  const UpdateTodoUsecase({required this.todoRepository});

  Future<Either<Failure, TodoEntity>> call(TodoEntity todo) {
    return todoRepository.updateTodo(todo);
  }
}
