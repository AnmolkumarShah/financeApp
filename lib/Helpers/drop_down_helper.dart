import 'package:flutter/material.dart';

String display(dynamic e) {
  try {
    return e.show();
  } catch (e) {
    return "Name";
  }
}

class Dropdown<T> {
  T? selected;
  List<T>? items;
  Function? fun;
  String? label;

  Dropdown({this.items, this.fun, this.selected, this.label});

  List<DropdownMenuItem<T>> buildItems(List<T>? li) {
    List<DropdownMenuItem<T>>? list = li!
        .map((e) => DropdownMenuItem<T>(
              child: Text(
                display(e!),
              ),
              value: e,
            ))
        .toList();
    return list;
  }

  Widget build() {
    return DropdownButtonHideUnderline(
      child: DropdownButton<T>(
        items: buildItems(items),
        onChanged: (value) {
          selected = value;
          fun!(value);
        },
        value: selected,
      ),
    );
  }
}

class RowMaker extends StatelessWidget {
  Widget? one;
  Widget? two;
  RowMaker({Key? key, this.one, this.two}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: one!,
        ),
        two!,
      ],
    );
  }
}
