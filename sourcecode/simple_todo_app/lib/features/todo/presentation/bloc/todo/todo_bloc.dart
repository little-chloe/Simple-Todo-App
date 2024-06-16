import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/features/todo/domain/usecases/create_todo_usecase.dart';
import 'package:simple_todo_app/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:simple_todo_app/features/todo/domain/usecases/get_all_todos_by_category_usecase.dart';
import 'package:simple_todo_app/features/todo/domain/usecases/get_all_todos_usecase.dart';
import 'package:simple_todo_app/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_event.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final CreateTodoUsecase _createTodo;
  final DeleteTodoUsecase _deleteTodo;
  final GetAllTodosUsecase _getAllTodos;
  final UpdateTodoUsecase _updateTodo;
  final GetAllTodosByCategoryUsecase _getAllTodosByCategoryUsecase;

  TodoBloc({
    required GetAllTodosByCategoryUsecase getAllTodosByCategory,
    required GetAllTodosUsecase getAllTodosUsecase,
    required CreateTodoUsecase createTodoUsecase,
    required DeleteTodoUsecase deleteTodoUsecase,
    required UpdateTodoUsecase updateTodoUsecase,
  })  : _createTodo = createTodoUsecase,
        _deleteTodo = deleteTodoUsecase,
        _getAllTodos = getAllTodosUsecase,
        _updateTodo = updateTodoUsecase,
        _getAllTodosByCategoryUsecase = getAllTodosByCategory,
        super(const TodoLoadingState()) {
    on<CreateTodoEvent>(_onCreateTodoEvent);
    // on<DeleteTodoEvent>(_onDeleteTodoEvent);
    on<UpdateTodoEvent>(_onUpdateTodoEvent);
    on<GetAllTodosByCategoryEvent>(_onGetAllTodosByCategoryEvent);
    on<GetAllTodosEvent>(_onGetAllTodosEvent);
    on<DeleteTodoEvent>(_onDeleteTodoEvent);
  }

  void _onUpdateTodoEvent(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    final updatedTodo = await _updateTodo(event.todo);

    updatedTodo.fold(
      (failure) => emit(TodoFailureState(failure: failure)),
      (todo) => emit(TodoUpdateSuccessState(todo: todo)),
    );
  }

  void _onCreateTodoEvent(
      CreateTodoEvent event, Emitter<TodoState> emit) async {
    final newTodo = await _createTodo(event.todo);

    newTodo.fold(
      (failure) => emit(TodoFailureState(failure: failure)),
      (todo) => emit(TodoCreateSuccessState(todo: todo)),
    );
  }

  void _onDeleteTodoEvent(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    final isDeleted = await _deleteTodo(event.id);

    isDeleted.fold(
      (failure) => emit(TodoFailureState(failure: failure)),
      (result) => emit(TodoDeleteSuccessState(id: result)),
    );
  }

  void _onGetAllTodosByCategoryEvent(
      GetAllTodosByCategoryEvent event, Emitter<TodoState> emit) async {
    final todos = await _getAllTodosByCategoryUsecase(event.category);

    todos.fold(
      (failure) => emit(TodoFailureState(failure: failure)),
      (listTodo) => emit(TodoByCategoryLoadingDoneState(todos: listTodo)),
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
