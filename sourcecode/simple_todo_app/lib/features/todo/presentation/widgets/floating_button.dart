import 'package:flutter/material.dart';
import 'package:simple_todo_app/core/constants/app_design_size.dart';
import 'package:simple_todo_app/core/themes/colors.dart';
import 'package:simple_todo_app/features/todo/presentation/pages/add_new_todo_page.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
  });

  void _handleNavigateAddTodoPage(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const AddNewTodoPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: SizedBox(
        width: (64 / AppDesignSize.width) * MediaQuery.of(context).size.width,
        height: (64 / AppDesignSize.width) * MediaQuery.of(context).size.width,
        child: FloatingActionButton(
          onPressed: () {
            _handleNavigateAddTodoPage(context);
          },
          backgroundColor: AppColors.colorWhite,
          shape: const CircleBorder(),
          elevation: 12,
          child: const Icon(
            Icons.add,
            color: AppColors.colorBlue,
            size: 32,
          ),
        ),
      ),
    );
  }
}
