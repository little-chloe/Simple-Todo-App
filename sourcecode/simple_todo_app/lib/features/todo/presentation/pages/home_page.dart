import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/core/constants/app_design_size.dart';
import 'package:simple_todo_app/core/themes/colors.dart';
import 'package:simple_todo_app/core/utils/convert_date_to_string.dart';
import 'package:simple_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_bloc.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_state.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/category_card.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/floating_button.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/home_bar.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/list_title.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoEntity> _todos = [];

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height *
                  44 /
                  AppDesignSize.height,
            ),
            child: BlocConsumer<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoFailureState) {
                  return Column(
                    children: [
                      const HomeBar(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.failure.errorMessage,
                              style: TextStyle(
                                color: AppColors.colorBlack.withOpacity(0.3),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                if (state is TodoLoadingState) {
                  const Column(
                    children: [
                      HomeBar(),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: AppColors.colorBlack,
                            )
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return Column(
                  children: [
                    const HomeBar(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ..._todos.where((todo) {
                              if (todo.date != null &&
                                  ConvertDateToString.dateToString(
                                          todo.date!) ==
                                      'Today') {
                                return true;
                              }
                              return false;
                            }).map((todo) {
                              return TodoItem(
                                todo: todo,
                                colors: [
                                  AppColors.colorBlack,
                                  AppColors.colorBlack.withOpacity(0.3),
                                  AppColors.colorOutline,
                                  AppColors.colorBlack.withOpacity(0.3),
                                ],
                              );
                            }),
                            const ListTitle(),
                            CategoryCard(
                              todos: _todos
                                  .where((todo) => todo.category == 'Inbox')
                                  .toList(),
                              title: 'Inbox',
                              colors: [
                                AppColors.colorBlack.withOpacity(0.9),
                                AppColors.colorBlack.withOpacity(0.5),
                                AppColors.colorListGrey
                              ],
                            ),
                            CategoryCard(
                              todos: _todos
                                  .where((todo) => todo.category == 'Work')
                                  .toList(),
                              colors: [
                                AppColors.colorWhite.withOpacity(0.9),
                                AppColors.colorWhite.withOpacity(0.5),
                                AppColors.colorListGreen,
                              ],
                              title: 'Work',
                            ),
                            CategoryCard(
                              todos: _todos
                                  .where((todo) => todo.category == 'Shopping')
                                  .toList(),
                              colors: [
                                AppColors.colorWhite.withOpacity(0.9),
                                AppColors.colorWhite.withOpacity(0.5),
                                AppColors.colorListRed,
                              ],
                              title: 'Shopping',
                            ),
                            CategoryCard(
                              todos: _todos
                                  .where((todo) => todo.category == 'Family')
                                  .toList(),
                              title: 'Family',
                              colors: [
                                AppColors.colorBlack.withOpacity(0.9),
                                AppColors.colorBlack.withOpacity(0.5),
                                AppColors.colorListYellow
                              ],
                            ),
                            CategoryCard(
                              todos: _todos
                                  .where((todo) => todo.category == 'Personal')
                                  .toList(),
                              colors: const [
                                AppColors.colorWhite,
                                AppColors.colorWhite,
                                AppColors.colorListPurple,
                              ],
                              title: 'Personal',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              listener: (BuildContext context, TodoState state) {
                if (state is TodoCreateSuccessState) {
                  setState(() {
                    _todos = [..._todos, state.todo];
                  });
                }
                if (state is TodoLoadingDoneState) {
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
                    _todos =
                        _todos.where((todo) => todo.id != state.id).toList();
                  });
                }
              },
            ),
          ),
          Positioned(
            bottom: deviceHeight *
                (AppDesignSize.height - 704 - 64) /
                AppDesignSize.height,
            right: deviceWidth *
                (AppDesignSize.width - 295 - 64) /
                AppDesignSize.width,
            child: const FloatingButton(),
          ),
        ],
      ),
    );
  }
}
