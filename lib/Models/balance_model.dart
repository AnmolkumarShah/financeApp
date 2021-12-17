import 'package:flutter/material.dart';

class BalanceModel {
  Widget builder() {
    TextStyle style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
    );
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: kElevationToShadow[2],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Save All",
              style: style,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.save_alt),
            label: const Text("Save"),
          )
        ],
      ),
    );
  }

  BalanceModel copy() {
    return new BalanceModel();
  }

  calculate() {}
  bool canNew() {
    return false;
  }

  String save(int id) {
    return '';
  }

  setValue(dynamic data) {}
}
