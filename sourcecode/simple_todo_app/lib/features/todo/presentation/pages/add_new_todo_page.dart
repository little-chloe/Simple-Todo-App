import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/core/constants/app_design_size.dart';
import 'package:simple_todo_app/core/themes/colors.dart';
import 'package:simple_todo_app/core/utils/get_selected_category_color.dart';
import 'package:simple_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_bloc.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_event.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_state.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/category_picker_item.dart';

class AddNewTodoPage extends StatefulWidget {
  const AddNewTodoPage({super.key});

  @override
  State<AddNewTodoPage> createState() => _AddNewTodoPageState();
}

class _AddNewTodoPageState extends State<AddNewTodoPage> {
  bool _showDatePicker = false;
  bool _showTimePicker = false;
  bool _showCategoryPicker = false;
  String _selectedCategory = 'Inbox';
  String _content = '';

  void _handleCreateTodo() {
    TodoEntity todo = TodoEntity(
      content: _content,
      category: _selectedCategory,
      isDone: false,
      createdAt: DateTime.now(),
    );
    context.read<TodoBloc>().add(CreateTodoEvent(todo: todo));
  }

  void _handleCancelAddTodo(context) {
    Navigator.of(context).pop();
  }

  void _handleShowDatePicker() {
    FocusScope.of(context).unfocus();
    setState(() {
      _showDatePicker = true;
      _showTimePicker = false;
      _showCategoryPicker = false;
    });
  }

  void _handleShowTimePicker() {
    FocusScope.of(context).unfocus();
    setState(() {
      _showDatePicker = false;
      _showTimePicker = true;
      _showCategoryPicker = false;
    });
  }

  void _handshowCategoryPicker() {
    FocusScope.of(context).unfocus();
    setState(() {
      _showDatePicker = false;
      _showTimePicker = false;
      _showCategoryPicker = true;
    });
  }

  void _handleCloseAllShowWidget() {
    setState(() {
      _showDatePicker = false;
      _showTimePicker = false;
      _showCategoryPicker = false;
    });
  }

  void _handleSelectCategory(String title) {
    setState(() {
      _selectedCategory = title;
    });
  }

  void _handleContentChange(String content) {
    setState(() {
      _content = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    late Widget showWidget;

    if (_showDatePicker) {
      showWidget = CalendarDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now(),
        onDateChanged: (date) {},
      );
    }

    if (_showCategoryPicker) {
      showWidget = Container(
        padding: EdgeInsets.symmetric(
          horizontal: deviceWidth * 16 / AppDesignSize.width,
        ),
        height: deviceHeight * 377 / AppDesignSize.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CategoryPicker(
                selectedCategory: _selectedCategory,
                handleSelected: _handleSelectCategory,
                colors: [
                  AppColors.colorBlack.withOpacity(0.9),
                  AppColors.colorBlack.withOpacity(0.5),
                  AppColors.colorListGrey,
                ],
                task: 1,
                title: 'Inbox',
              ),
              CategoryPicker(
                selectedCategory: _selectedCategory,
                handleSelected: _handleSelectCategory,
                colors: [
                  AppColors.colorWhite.withOpacity(0.9),
                  AppColors.colorWhite.withOpacity(0.5),
                  AppColors.colorListGreen,
                ],
                task: 2,
                title: 'Work',
              ),
              CategoryPicker(
                selectedCategory: _selectedCategory,
                handleSelected: _handleSelectCategory,
                colors: [
                  AppColors.colorWhite.withOpacity(0.9),
                  AppColors.colorWhite.withOpacity(0.5),
                  AppColors.colorListRed,
                ],
                task: 3,
                title: 'Shopping',
              ),
              CategoryPicker(
                selectedCategory: _selectedCategory,
                handleSelected: _handleSelectCategory,
                colors: [
                  AppColors.colorBlack.withOpacity(0.9),
                  AppColors.colorBlack.withOpacity(0.5),
                  AppColors.colorListYellow,
                ],
                task: 1,
                title: 'Family',
              ),
              CategoryPicker(
                selectedCategory: _selectedCategory,
                handleSelected: _handleSelectCategory,
                colors: const [
                  AppColors.colorWhite,
                  AppColors.colorWhite,
                  AppColors.colorListPurple,
                ],
                task: 4,
                title: 'Personal',
              ),
            ],
          ),
        ),
      );
    }

    return BlocConsumer<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is TodoSuccessState) {
          Navigator.of(context).pop();
        }
        if (state is TodoFailureState) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(state.failure.errorMessage),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.colorWhite,
          body: Padding(
            padding: EdgeInsets.only(
              top: deviceHeight * 44 / AppDesignSize.height,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceWidth * 16 / AppDesignSize.width / 2,
                  ),
                  width: double.infinity,
                  height: deviceHeight * 44 / AppDesignSize.height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          _handleCancelAddTodo(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: AppColors.colorBlue,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _handleCreateTodo,
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            color: AppColors.colorBlue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 16 / AppDesignSize.width / 2,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.circle_outlined,
                          ),
                          iconSize: 36,
                          color: AppColors.colorOutline,
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                (12 / AppDesignSize.width) * deviceWidth,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: TextField(
                                  onChanged: (value) {
                                    _handleContentChange(value);
                                  },
                                  onTap: _handleCloseAllShowWidget,
                                  maxLines: null,
                                  expands: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'What do you want to do?',
                                    hintStyle: TextStyle(
                                      color: AppColors.colorBlack
                                          .withOpacity(0.15),
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: deviceHeight * 9 / AppDesignSize.height,
                    bottom: deviceHeight * 9 / AppDesignSize.height,
                    left: deviceWidth * 7 / AppDesignSize.width,
                    right: deviceWidth * 7 / AppDesignSize.width * 2,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: AppColors.colorBlack.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _handleShowDatePicker,
                        icon: const Icon(
                          Icons.calendar_month,
                        ),
                        iconSize: deviceWidth * 24 / AppDesignSize.width,
                        color: AppColors.colorBlack.withOpacity(0.3),
                      ),
                      SizedBox(
                        width: deviceWidth *
                            (58 - 24 - 14) /
                            AppDesignSize.width /
                            2,
                      ),
                      IconButton(
                        onPressed: _handleShowTimePicker,
                        icon: const Icon(Icons.alarm),
                        iconSize: deviceWidth * 24 / AppDesignSize.width,
                        color: AppColors.colorBlack.withOpacity(0.3),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: _handshowCategoryPicker,
                        child: Text(
                          _selectedCategory,
                          style: const TextStyle(
                            color: AppColors.colorBlue,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: deviceWidth *
                            (347 - 300 - 39) /
                            AppDesignSize.width,
                      ),
                      Icon(
                        Icons.circle,
                        color:
                            GetSelectedCategoryColor.toColor(_selectedCategory),
                        size: deviceWidth * 12 / AppDesignSize.width,
                      ),
                    ],
                  ),
                ),
                if (_showCategoryPicker || _showDatePicker || _showTimePicker)
                  showWidget,
              ],
            ),
          ),
        );
      },
    );
  }
}
