import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_todo_app/features/todo/data/datasources/todo_local_datasource.dart';
import 'package:simple_todo_app/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:simple_todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:simple_todo_app/features/todo/domain/usecases/create_todo_usecase.dart';
import 'package:simple_todo_app/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:simple_todo_app/features/todo/domain/usecases/get_all_todos_usecase.dart';
import 'package:simple_todo_app/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_bloc.dart';
import 'package:sqflite/sqflite.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  final appDirectory = await getApplicationDocumentsDirectory();
  final dbPath = join(appDirectory.path, 'todo_app_database.db');
  final database = await openDatabase(
    dbPath,
    version: 1,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE todos(
          id INTEGER PRIMARY KEY,
          category TEXT,
          content TEXT,
          created_at TEXT
          time TEXT
          date TEXT,
          is_done INTEGER 
        )
      ''');
    },
  );

  // dio
  getIt.registerSingleton(Dio());

  // dependencies
  getIt.registerSingleton(TodoLocalDataSource(database: database));

  // repositories
  getIt.registerSingleton<TodoRepository>(TodoRepositoryImpl(todoLocalDataSource: getIt()));

  // usecase
  getIt.registerSingleton(CreateTodoUsecase(todoRepository: getIt()));

  getIt.registerSingleton(DeleteTodoUsecase(todoRepository: getIt()));

  getIt.registerSingleton(GetAllTodosUsecase(todoRepository: getIt()));

  getIt.registerSingleton(UpdateTodoUsecase(todoRepository: getIt()));

  // bloc
  getIt.registerFactory(
    () => TodoBloc(
      createTodoUsecase: getIt(),
      deleteTodoUsecase: getIt(),
      getAllTodosUsecase: getIt(),
      updateTodoUsecase: getIt(),
    ),
  );
}
