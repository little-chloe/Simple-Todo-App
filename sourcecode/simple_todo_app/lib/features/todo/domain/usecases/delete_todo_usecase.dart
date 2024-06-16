import 'package:dartz/dartz.dart';
import 'package:simple_todo_app/core/failures/failure.dart';
import 'package:simple_todo_app/features/todo/domain/repositories/todo_repository.dart';

class DeleteTodoUsecase {
  final TodoRepository todoRepository;

  const DeleteTodoUsecase({required this.todoRepository});

  Future<Either<Failure, int>> call(int id) {
    return todoRepository.deleteTodo(id);
  }
}
