import 'package:flutter/material.dart';
import 'package:simple_todo_app/core/constants/app_design_size.dart';
import 'package:simple_todo_app/core/themes/colors.dart';
import 'package:simple_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/category_picker_item.dart';

class CategoryPicker extends StatelessWidget {
  final List<TodoEntity> todos;
  final String selectedCategory;
  final void Function(String title) handleSelectedCategory;

  const CategoryPicker({
    super.key,
    required this.handleSelectedCategory,
    required this.selectedCategory,
    required this.todos,
  });

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: deviceWidth * 16 / AppDesignSize.width,
      ),
      height: deviceHeight * 377 / AppDesignSize.height,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CategoryPickerItem(
              selectedCategory: selectedCategory,
              handleSelected: handleSelectedCategory,
              colors: [
                AppColors.colorBlack.withOpacity(0.9),
                AppColors.colorBlack.withOpacity(0.5),
                AppColors.colorListGrey,
              ],
              task: todos.where((todo) => todo.category == 'Inbox').length,
              title: 'Inbox',
            ),
            CategoryPickerItem(
              selectedCategory: selectedCategory,
              handleSelected: handleSelectedCategory,
              colors: [
                AppColors.colorWhite.withOpacity(0.9),
                AppColors.colorWhite.withOpacity(0.5),
                AppColors.colorListGreen,
              ],
              task: todos.where((todo) => todo.category == 'Work').length,
              title: 'Work',
            ),
            CategoryPickerItem(
              selectedCategory: selectedCategory,
              handleSelected: handleSelectedCategory,
              colors: [
                AppColors.colorWhite.withOpacity(0.9),
                AppColors.colorWhite.withOpacity(0.5),
                AppColors.colorListRed,
              ],
              task: todos.where((todo) => todo.category == 'Shopping').length,
              title: 'Shopping',
            ),
            CategoryPickerItem(
              selectedCategory: selectedCategory,
              handleSelected: handleSelectedCategory,
              colors: [
                AppColors.colorBlack.withOpacity(0.9),
                AppColors.colorBlack.withOpacity(0.5),
                AppColors.colorListYellow,
              ],
              task: todos.where((todo) => todo.category == 'Family').length,
              title: 'Family',
            ),
            CategoryPickerItem(
              selectedCategory: selectedCategory,
              handleSelected: handleSelectedCategory,
              colors: const [
                AppColors.colorWhite,
                AppColors.colorWhite,
                AppColors.colorListPurple,
              ],
              task: todos.where((todo) => todo.category == 'Personal').length,
              title: 'Personal',
            ),
          ],
        ),
      ),
    );
  }
}
