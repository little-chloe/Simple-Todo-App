import 'package:flutter/material.dart';
import 'package:simple_todo_app/core/constants/app_design_size.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final int tasks;
  final List<Color> colors;

  const CategoryCard({
    required this.colors,
    required this.tasks,
    required this.title,
    super.key,
  });

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
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.of(context).size.width * 16 / AppDesignSize.width,
            vertical:
                MediaQuery.of(context).size.height * 12 / AppDesignSize.height,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors[2],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: colors[0],
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$tasks ${tasks > 1 ? 'tasks' : 'task'}',
                style: TextStyle(
                  color: colors[1],
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
