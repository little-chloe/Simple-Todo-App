import 'package:flutter/material.dart';
import 'package:simple_todo_app/core/themes/colors.dart';

class GetSelectedCategoryColor {
  static Color toColor(String title) {
    switch (title) {
      case 'Inbox':
        return AppColors.colorListGrey;
      case 'Work':
        return AppColors.colorListGreen;
      case 'Shopping':
        return AppColors.colorListRed;
      case 'Family':
        return AppColors.colorListYellow;
      case 'Personal':
        return AppColors.colorListPurple;
      default:
        return AppColors.colorListGrey;
    }
  }
}
