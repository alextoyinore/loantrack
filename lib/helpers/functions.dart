String todayToString({required DateTime date}) {
  var year = DateTime(date.year).toString();
  var month = DateTime(date.month).toString();
  var day = DateTime(date.day).toString();

  if (int.parse(month) < 10) {
    month = '0${month}';
  }

  if (int.parse(day) < 10) {
    day = '0${day}';
  }

  return '${year}-${month}-${day}';
}
