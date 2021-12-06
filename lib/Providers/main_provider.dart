import 'package:flutter/cupertino.dart';

class MainProvider with ChangeNotifier {
  dynamic data;
  setData(dynamic d) {
    data = d;
    notifyListeners();
  }

  dynamic getData() {
    return data;
  }
}
