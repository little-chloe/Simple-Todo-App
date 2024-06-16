import 'package:flutter/material.dart';
import 'package:simple_todo_app/core/constants/app_design_size.dart';
import 'package:simple_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:simple_todo_app/features/todo/presentation/widgets/category_bottom_sheet.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final List<Color> colors;
  final List<TodoEntity> todos;

  const CategoryCard({
    required this.todos,
    required this.colors,
    required this.title,
    super.key,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  void _handleOnTapCategory() {
    final deviceHeight = MediaQuery.of(context).size.height;

    showBottomSheet(
      context: context,
      builder: (context) {
        return CategoryBottomSheet(
          category: widget.title,
          deviceHeight: deviceHeight,
          colors: widget.colors,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 58 / AppDesignSize.width,
        right: MediaQuery.of(context).size.width *
            (AppDesignSize.width - 58 - 301) /
            AppDesignSize.width,
        bottom: MediaQuery.of(context).size.height *
            (77 - 69) /
            AppDesignSize.height,
      ),
      child: InkWell(
        onTap: _handleOnTapCategory,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.of(context).size.width * 16 / AppDesignSize.width,
            vertical:
                MediaQuery.of(context).size.height * 12 / AppDesignSize.height,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.colors[2],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.colors[0],
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${widget.todos.length} ${widget.todos.length > 1 ? 'tasks' : 'task'}',
                style: TextStyle(
                  color: widget.colors[1],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
