import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/features/todo/domain/usecases/create_todo_usecase.dart';
import 'package:simple_todo_app/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:simple_todo_app/features/todo/domain/usecases/get_all_todos_usecase.dart';
import 'package:simple_todo_app/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_event.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final CreateTodoUsecase _createTodo;
  final DeleteTodoUsecase _deleteTodo;
  final GetAllTodosUsecase _getAllTodos;
  final UpdateTodoUsecase _updateTodo;

  TodoBloc({
    required GetAllTodosUsecase getAllTodosUsecase,
    required CreateTodoUsecase createTodoUsecase,
    required DeleteTodoUsecase deleteTodoUsecase,
    required UpdateTodoUsecase updateTodoUsecase,
  })  : _createTodo = createTodoUsecase,
        _deleteTodo = deleteTodoUsecase,
        _getAllTodos = getAllTodosUsecase,
        _updateTodo = updateTodoUsecase,
        super(const TodoLoadingState()) {
    on<CreateTodoEvent>(_onCreateTodoEvent);
    on<DeleteTodoEvent>(_onDeleteTodoEvent);
    on<GetAllTodosEvent>(_onGetAllTodosEvent);
    on<UpdateTodoEvent>(_onUpdateTodoEvent);
  }

  void _onUpdateTodoEvent(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    final updatedTodo = await _updateTodo(event.todo);

    updatedTodo.fold(
      (failure) => emit(TodoFailureState(failure: failure)),
      (todo) => emit(const TodoSuccessState()),
    );
  }

  void _onCreateTodoEvent(
      CreateTodoEvent event, Emitter<TodoState> emit) async {
    final newTodo = await _createTodo(event.todo);

    newTodo.fold(
      (failure) => emit(TodoFailureState(failure: failure)),
      (todo) => emit(const TodoSuccessState()),
    );
  }

  void _onDeleteTodoEvent(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    final isDeleted = await _deleteTodo(event.id);

    isDeleted.fold(
      (failure) => emit(TodoFailureState(failure: failure)),
      (result) => emit(const TodoSuccessState()),
    );
  }

  void _onGetAllTodosEvent(
      GetAllTodosEvent event, Emitter<TodoState> emit) async {
    final todos = await _getAllTodos();

    todos.fold(
      (failure) => emit(TodoFailureState(failure: failure)),
      (listTodo) => emit(TodoLoadingDoneState(todos: listTodo)),
    );
  }
}
