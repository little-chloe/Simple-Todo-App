import 'package:dartz/dartz.dart';
import 'package:simple_todo_app/core/exceptions/cache_exception.dart';
import 'package:simple_todo_app/core/exceptions/data_not_found_exception.dart';
import 'package:simple_todo_app/core/failures/cache_failure.dart';
import 'package:simple_todo_app/core/failures/data_not_found_failure.dart';
import 'package:simple_todo_app/core/failures/failure.dart';
import 'package:simple_todo_app/features/todo/data/datasources/todo_local_datasource.dart';
import 'package:simple_todo_app/features/todo/data/models/todo_model.dart';
import 'package:simple_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:simple_todo_app/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource todoLocalDataSource;

  const TodoRepositoryImpl({required this.todoLocalDataSource});

  @override
  Future<Either<Failure, TodoModel>> createTodo(TodoEntity todo) async {
    try {
      final todoSaved =
          await todoLocalDataSource.saveTodo(TodoModel.fromEntity(todo));
      return Right(todoSaved);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'Cache error occur.'));
    }
  }

  @override
  Future<Either<Failure, List<TodoModel>>> getAllTodos() async {
    try {
      final todos = await todoLocalDataSource.getAllTodos();
      return Right(todos);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'Cache error occur.'));
    }
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getAllTodosByCategory(
      String category) async {
    try {
      final todos = await todoLocalDataSource.getAllTodosByCategory(category);
      return Right(todos);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'Cache error occur.'));
    }
  }

  @override
  Future<Either<Failure, int>> deleteTodo(int id) async {
    try {
      await todoLocalDataSource.deleteTodo(id);
      return Right(id);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'Cache error occur.'));
    }
  }

  @override
  Future<Either<Failure, TodoEntity>> updateTodo(TodoEntity todo) async {
    try {
      final newTodo =
          await todoLocalDataSource.updateTodo(TodoModel.fromEntity(todo));
      return Right(newTodo);
    } on CacheException {
      return Left(CacheFailure(errorMessage: 'Cache error occur.'));
    } on DataNotFoundException {
      return Left(DataNotFoundFailure(
          errorMessage: 'Todo with id ${todo.id} not found'));
    }
  }
}
