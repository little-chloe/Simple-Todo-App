import 'package:flutter/material.dart';
import 'package:simple_todo_app/core/constants/app_design_size.dart';
import 'package:simple_todo_app/core/themes/colors.dart';

class ListTitle extends StatelessWidget {
  const ListTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height *
            (483 - 448 - 20) /
            AppDesignSize.height,
        top: MediaQuery.of(context).size.height *
            (448 - 356 - 60) /
            AppDesignSize.height,
        left: (60 / AppDesignSize.width) * MediaQuery.of(context).size.width,
      ),
      child: Row(
        children: [
          Text(
            'Lists',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.colorBlack.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
