import 'package:flutter/material.dart';
import 'package:simple_todo_app/core/constants/app_design_size.dart';
import 'package:simple_todo_app/core/themes/colors.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (73 / AppDesignSize.height) * MediaQuery.of(context).size.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: (60 / AppDesignSize.width) *
                  MediaQuery.of(context).size.width,
            ),
            child: const Text(
              'Today',
              style: TextStyle(
                color: AppColors.colorBlack,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.more_horiz),
          //   color: AppColors.colorBlue,
          //   iconSize: 32,
          // ),
        ],
      ),
    );
  }
}
