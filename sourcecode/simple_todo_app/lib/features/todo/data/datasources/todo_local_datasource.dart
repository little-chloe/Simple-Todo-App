import 'package:simple_todo_app/core/constants/todo_json_key.dart';
import 'package:simple_todo_app/core/exceptions/cache_exception.dart';
import 'package:simple_todo_app/core/exceptions/data_not_found_exception.dart';
import 'package:simple_todo_app/features/todo/data/models/todo_model.dart';
import 'package:sqflite/sqflite.dart';

const kTodoTable = 'todos';

class TodoLocalDataSource {
  final Database database;

  const TodoLocalDataSource({required this.database});

  Future<List<TodoModel>> getAllTodos() async {
    try {
      List<Map<String, dynamic>> jsonData = await database.query(kTodoTable);
      return jsonData.map((data) => TodoModel.fromJson(data)).toList();
    } catch (e) {
      throw CacheException();
    }
  }

  Future<TodoModel> saveTodo(TodoModel todo) async {
    try {
      int id = await database.insert(kTodoTable, todo.toJson(),
          conflictAlgorithm: ConflictAlgorithm.rollback);
      return todo.copyWith(newId: id);
    } catch (e) {
      throw CacheException();
    }
  }

  Future<TodoModel> updateTodo(TodoModel todo) async {
    try {
      int rowEffected = await database.update(
        kTodoTable,
        todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: '${TodoJsonKey.kId} = ?',
        whereArgs: [todo.id],
      );
      if (rowEffected == 1) {
        return todo;
      } else {
        throw DataNotFoundException();
      }
    } catch (e) {
      throw CacheException();
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      int rowEffected = await database.delete(
        kTodoTable,
        where: '${TodoJsonKey.kId} = ?',
        whereArgs: [id],
      );
      if (rowEffected == 1) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw CacheException();
    }
  }
}
