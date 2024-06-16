import 'package:dartz/dartz.dart';
import 'package:simple_todo_app/core/failures/failure.dart';
import 'package:simple_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:simple_todo_app/features/todo/domain/repositories/todo_repository.dart';

class GetAllTodosByCategoryUsecase {
  final TodoRepository todoRepository;

  const GetAllTodosByCategoryUsecase({required this.todoRepository});

  Future<Either<Failure, List<TodoEntity>>> call(String category) {
    return todoRepository.getAllTodosByCategory(category);
  }
}
