import 'package:flutter/material.dart';
import 'package:simple_todo_app/core/constants/app_design_size.dart';
import 'package:simple_todo_app/core/themes/colors.dart';

class TodayTodoItem extends StatelessWidget {
  const TodayTodoItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  color: AppColors.colorBlack.withOpacity(0.1),
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
                      const Text(
                        'Buy a chocolate for Charlotte',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.colorBlack,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.alarm,
                            color: AppColors.colorBlack.withOpacity(0.3),
                            size: 16,
                          ),
                          Text(
                            ' 7:00 pm',
                            style: TextStyle(
                              color: AppColors.colorBlack.withOpacity(0.3),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    right: 16,
                    left: 16,
                  ),
                  child: Icon(
                    Icons.circle_rounded,
                    color: AppColors.colorListGreen,
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
