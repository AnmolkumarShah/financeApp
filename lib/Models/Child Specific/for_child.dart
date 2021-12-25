import 'package:finance_app/Helpers/focus_change.dart';
import 'package:finance_app/Helpers/text_form_field_helper.dart';
import 'package:finance_app/Models/balance_model.dart';
import 'package:flutter/material.dart';

class ForChild extends BalanceModel {
  int number = 1;
  Input amount = Input.number(label: "Amount In Lakhs");
  Input details = Input(label: "Details");
  Input currInvestmentDetails = Input(label: "Current Investment Details");
  Input currInvestmentValue = Input.number(label: "Current Investment Value");

  String heading = "Some Heading";
  bool isNew = false;
  dynamic data;
  double? result;
  String? name;

  functionOnAmount() {}
  bool canNew() {
    return isNew;
  }

  double calculate() {
    double value = currInvestmentValue.valueInt() - amount.valueInt();
    result = value;
    return value;
  }

  copy() {
    ForChild temp = new ForChild();
    return temp;
  }

  builder() {
    TextStyle style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
    );
    TextEditingController Acon = amount.getController();
    Acon.addListener(() {
      print(calculate());
    });
    TextEditingController Icon = currInvestmentValue.getController();
    Icon.addListener(() {
      print(calculate());
    });
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
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
              heading,
              style: style,
            ),
          ),
          FocusChange(
            widget: amount.builder(),
            callback: functionOnAmount,
          ),
          details.builder(),
          currInvestmentDetails.builder(),
          FocusChange(
            widget: currInvestmentValue.builder(),
            callback: functionOnAmount,
          ),
          ListTile(
            leading: Text("Deficit / Surplus"),
            trailing: Text(calculate().toString()),
          ),
        ],
      ),
    );
  }

  String save(int id) {
    return '';
  }

  setValue(dynamic data) {}
}
