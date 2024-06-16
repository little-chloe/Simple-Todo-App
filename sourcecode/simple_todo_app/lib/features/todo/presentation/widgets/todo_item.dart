import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/core/constants/app_design_size.dart';
import 'package:simple_todo_app/core/themes/colors.dart';
import 'package:simple_todo_app/core/utils/convert_date_to_string.dart';
import 'package:simple_todo_app/core/utils/convert_time_to_string.dart';
import 'package:simple_todo_app/core/utils/get_selected_category_color.dart';
import 'package:simple_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_bloc.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_event.dart';

class TodoItem extends StatelessWidget {
  final TodoEntity todo;
  final List<Color> colors;

  const TodoItem({
    required this.colors,
    required this.todo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        IconButton(
          onPressed: () {
            context.read<TodoBloc>().add(DeleteTodoEvent(id: todo.id!));
          },
          icon: todo.isDone!
              ? const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.colorBlue,
                )
              : Icon(
                  Icons.circle_outlined,
                  color: colors[2],
                ),
          iconSize: 36,
          color: colors[2],
          padding: EdgeInsets.symmetric(
            horizontal:
                (12 / AppDesignSize.width) * MediaQuery.of(context).size.width,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(
              top: (19 / AppDesignSize.height) *
                  MediaQuery.of(context).size.height,
              bottom: (19 / AppDesignSize.height) *
                  MediaQuery.of(context).size.height,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: colors[3],
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        todo.content!,
                        style: TextStyle(
                          fontSize: 16,
                          color: colors[0],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          if (todo.date != null)
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: colors[1],
                                  size: 16,
                                ),
                                Text(
                                  ConvertDateToString.dateToString(todo.date!),
                                  style: TextStyle(
                                    color: colors[1],
                                  ),
                                )
                              ],
                            ),
                          if (todo.date != null)
                            SizedBox(
                              width: deviceWidth *
                                  (131 - 60 - 59) /
                                  AppDesignSize.width,
                            ),
                          if (todo.time != null)
                            Row(
                              children: [
                                Icon(
                                  Icons.alarm,
                                  color: colors[1],
                                  size: 16,
                                ),
                                Text(
                                  ConvertTimeToString.timeToString(todo.time!),
                                  style: TextStyle(
                                    color: colors[1],
                                  ),
                                )
                              ],
                            ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 16,
                    left: 16,
                  ),
                  child: Icon(
                    Icons.circle_rounded,
                    color: GetSelectedCategoryColor.toColor(todo.category!),
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
