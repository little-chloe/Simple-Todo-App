import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/core/constants/app_design_size.dart';
import 'package:simple_todo_app/core/themes/colors.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_bloc.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_state.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/category_card.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/floating_button.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/home_bar.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/list_title.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/today_todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingButton(),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 44 / AppDesignSize.height,
        ),
        child: BlocConsumer<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoadingState) {
              return const Column(
                children: [
                  HomeBar(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [CircularProgressIndicator()],
                    ),
                  ),
                ],
              );
            }
            if (state is TodoLoadingDoneState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const HomeBar(),
                    for (int i = 0; i < state.todos.length; i++)
                      const TodayTodoItem(),
                    const ListTitle(),
                    CategoryCard(
                      title: 'Inbox',
                      tasks: 0,
                      colors: [
                        AppColors.colorBlack.withOpacity(0.9),
                        AppColors.colorBlack.withOpacity(0.5),
                        AppColors.colorListGrey
                      ],
                    ),
                    CategoryCard(
                      colors: [
                        AppColors.colorWhite.withOpacity(0.9),
                        AppColors.colorWhite.withOpacity(0.5),
                        AppColors.colorListGreen,
                      ],
                      tasks: 0,
                      title: 'Work',
                    ),
                    CategoryCard(
                      colors: [
                        AppColors.colorWhite.withOpacity(0.9),
                        AppColors.colorWhite.withOpacity(0.5),
                        AppColors.colorListRed,
                      ],
                      tasks: 0,
                      title: 'Shopping',
                    ),
                    CategoryCard(
                      title: 'Inbox',
                      tasks: 0,
                      colors: [
                        AppColors.colorBlack.withOpacity(0.9),
                        AppColors.colorBlack.withOpacity(0.5),
                        AppColors.colorListYellow
                      ],
                    ),
                    const CategoryCard(
                      colors: [
                        AppColors.colorWhite,
                        AppColors.colorWhite,
                        AppColors.colorListPurple,
                      ],
                      tasks: 0,
                      title: 'Shopping',
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
          listener: (BuildContext context, TodoState state) {
            if (state is TodoFailureState) {
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog();
                },
              );
            }
          },
        ),
      ),
    );
  }
}
