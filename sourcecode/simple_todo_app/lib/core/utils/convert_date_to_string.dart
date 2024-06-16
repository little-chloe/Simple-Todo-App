class ConvertDateToString {
  static String dateToString(DateTime datetime) {
    final day = datetime.day;
    final month = datetime.month;
    final year = datetime.year;

    final currentDateTime = DateTime.now();

    if (currentDateTime.day == day &&
        currentDateTime.month == month &&
        currentDateTime.year == year) {
      return 'Today';
    }
    if (currentDateTime.day == day - 1 &&
        currentDateTime.month == month &&
        currentDateTime.year == year) {
      return 'Tomorrow';
    }
    if (currentDateTime.day == day + 1 &&
        currentDateTime.month == month &&
        currentDateTime.year == year) {
      return 'Yesterday';
    }
    return '$day/$month/$year';
  }
}
