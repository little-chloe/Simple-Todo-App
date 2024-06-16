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
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_state.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/category_picker.dart';

class AddNewTodoPage extends StatefulWidget {
  const AddNewTodoPage({super.key});

  @override
  State<AddNewTodoPage> createState() => _AddNewTodoPageState();
}

class _AddNewTodoPageState extends State<AddNewTodoPage> {
  bool _showCategoryPicker = false;
  String _selectedCategory = 'Inbox';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _content = '';

  void _handleCreateTodo() {
    FocusScope.of(context).unfocus();
    setState(() {
      _showCategoryPicker = false;
    });
    TodoEntity todo = TodoEntity(
      content: _content,
      category: _selectedCategory,
      isDone: false,
      createdAt: DateTime.now(),
      date: _selectedDate,
      time: _selectedTime,
    );
    context.read<TodoBloc>().add(CreateTodoEvent(todo: todo));
  }

  void _handleCancelAddTodo(context) {
    Navigator.of(context).pop();
  }

  void _handleShowDatePicker() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _showCategoryPicker = false;
    });

    final date = await showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void _handleShowTimePicker() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _showCategoryPicker = false;
    });
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  void _handshowCategoryPicker() {
    context.read<TodoBloc>().add(const GetAllTodosEvent());
    FocusScope.of(context).unfocus();
    setState(() {
      _showCategoryPicker = true;
    });
  }

  void _handleCloseAllShowWidget() {
    setState(() {
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

    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoCreateSuccessState) {
            Navigator.of(context).pop();
          }
          if (state is TodoFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.failure.errorMessage,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              top: deviceHeight * 44 / AppDesignSize.height,
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceWidth * 16 / AppDesignSize.width / 2,
                    vertical:
                        deviceHeight * (44 - 22) / 2 / AppDesignSize.height,
                  ),
                  width: double.infinity,
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
                              Row(
                                children: [
                                  if (_selectedDate != null)
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: AppColors.colorBlack
                                              .withOpacity(0.3),
                                          size: 16,
                                        ),
                                        Text(
                                          ConvertDateToString.dateToString(
                                              _selectedDate!),
                                          style: TextStyle(
                                            color: AppColors.colorBlack
                                                .withOpacity(0.3),
                                          ),
                                        )
                                      ],
                                    ),
                                  if (_selectedDate != null)
                                    SizedBox(
                                      width: deviceWidth *
                                          (131 - 60 - 59) /
                                          AppDesignSize.width,
                                    ),
                                  if (_selectedTime != null)
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.alarm,
                                          color: AppColors.colorBlack
                                              .withOpacity(0.3),
                                          size: 16,
                                        ),
                                        Text(
                                          ConvertTimeToString.timeToString(
                                              _selectedTime!),
                                          style: TextStyle(
                                            color: AppColors.colorBlack
                                                .withOpacity(0.3),
                                          ),
                                        )
                                      ],
                                    ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    deviceHeight * 16 / AppDesignSize.height,
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
                if (_showCategoryPicker && state is TodoLoadingDoneState)
                  CategoryPicker(
                    handleSelectedCategory: _handleSelectCategory,
                    selectedCategory: _selectedCategory,
                    todos: state.todos,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
