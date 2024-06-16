import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/core/constants/app_design_size.dart';
import 'package:simple_todo_app/core/themes/colors.dart';
import 'package:simple_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_bloc.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_event.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_state.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/todo_item.dart';

class CategoryBottomSheet extends StatefulWidget {
  const CategoryBottomSheet({
    required this.category,
    super.key,
    required this.deviceHeight,
    required this.colors,
  });

  final String category;
  final double deviceHeight;
  final List<Color> colors;

  @override
  State<CategoryBottomSheet> createState() => _CategoryBottomSheetState();
}

class _CategoryBottomSheetState extends State<CategoryBottomSheet> {
  List<TodoEntity> _todos = [];

  @override
  void initState() {
    context
        .read<TodoBloc>()
        .add(GetAllTodosByCategoryEvent(category: widget.category));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      height: deviceHeight * 759 / AppDesignSize.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.colors[2],
        borderRadius: BorderRadius.circular(12),
      ),
      child: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoByCategoryLoadingDoneState) {
            setState(() {
              _todos = state.todos;
            });
          }
          if (state is TodoUpdateSuccessState) {
            setState(() {
              _todos = _todos.map((todo) {
                if (todo.id == state.todo.id) {
                  return state.todo;
                } else {
                  return todo;
                }
              }).toList();
            });
          }
          if (state is TodoDeleteSuccessState) {
            setState(() {
              _todos = _todos.where((todo) => todo.id != state.id).toList();
            });
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: deviceWidth * 60 / AppDesignSize.width,
                  top: deviceHeight * 16 / AppDesignSize.height,
                  bottom: deviceHeight * 16 / AppDesignSize.height,
                  right: deviceWidth * 16 / AppDesignSize.width,
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.category,
                      style: TextStyle(
                        fontSize: 32,
                        color: widget.colors[0],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_todos.length} ${_todos.length > 1 ? 'tasks' : 'task'}',
                      style: TextStyle(
                        fontSize: 16,
                        color: widget.colors[1],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ..._todos.map((todo) {
                        List<Color> colors = [];

                        if (todo.category == 'Inbox' ||
                            todo.category == 'Family') {
                          colors = [
                            AppColors.colorBlack,
                            AppColors.colorBlack.withOpacity(0.3),
                            AppColors.colorOutline,
                            AppColors.colorBlack.withOpacity(0.1),
                          ];
                        }

                        if (todo.category == 'Work' ||
                            todo.category == 'Shopping' ||
                            todo.category == 'Personal') {
                          colors = [
                            AppColors.colorWhite,
                            AppColors.colorWhite.withOpacity(0.5),
                            AppColors.colorWhite,
                            AppColors.colorWhite.withOpacity(0.2)
                          ];
                        }

                        return TodoItem(
                          todo: todo,
                          colors: colors,
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
