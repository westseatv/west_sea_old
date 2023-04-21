String date() {
  String day = DateTime.now().day > 9
      ? DateTime.now().day.toString()
      : '0${DateTime.now().day}';
  String month = DateTime.now().month > 9
      ? DateTime.now().month.toString()
      : '0${DateTime.now().month}';
  String year = DateTime.now().year > 9
      ? DateTime.now().year.toString()
      : '0${DateTime.now().year}';

  return '$day/$month/$year';
}
