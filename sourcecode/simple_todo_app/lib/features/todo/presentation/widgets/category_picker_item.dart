import 'package:flutter/material.dart';
import 'package:simple_todo_app/core/constants/app_design_size.dart';
import 'package:simple_todo_app/core/themes/colors.dart';

class CategoryPicker extends StatefulWidget {
  final String selectedCategory;
  final String title;
  final int task;
  final List<Color> colors;
  final void Function(String title) handleSelected;

  const CategoryPicker({
    super.key,
    required this.selectedCategory,
    required this.handleSelected,
    required this.colors,
    required this.task,
    required this.title,
  });

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        bottom: deviceHeight * (77 - 69) / AppDesignSize.height,
      ),
      child: InkWell(
        onTap: () {
          widget.handleSelected(widget.title);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 16 / AppDesignSize.width,
            vertical: deviceHeight * 12 / AppDesignSize.height,
          ),
          decoration: BoxDecoration(
            color: widget.colors[2],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: widget.colors[0],
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                      ),
                    ),
                    Text(
                      '${widget.task} ${widget.task > 1 ? 'tasks' : 'task'}',
                      style: TextStyle(
                        color: widget.colors[1],
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
              if (widget.selectedCategory == widget.title)
                Container(
                  width: deviceWidth * 28 / AppDesignSize.width,
                  height: deviceWidth * 28 / AppDesignSize.width,
                  decoration: const BoxDecoration(
                    color: AppColors.colorWhite,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: AppColors.colorBlue,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
