String formateDate(DateTime date) {
  try {
    final List<String> list = date.toIso8601String().split('T');
    return list[0] + " " + list[1].substring(0, 5);
  } catch (e) {
    print(e);
    return '-1';
  }
}
