import 'package:finance_app/Helpers/text_form_field_helper.dart';
import 'package:finance_app/Models/balance_model.dart';
import 'package:flutter/material.dart';

class Expenses extends BalanceModel {
  Input expenses = Input.number(label: "Monthly Expenses");
  Input value = Input.number(label: "Your replacement Value");
  Input rep_assets = Input(label: "Replacement value Assets");
  Input asset_value = Input.number(label: "Asset value in Lakhs");

  String heading = "Monthly Expenses";
  bool isNew = false;

  double calculate() {
    double val = asset_value.valueInt() - value.valueInt();
    return val;
  }

  double totalRequirement() {
    return expenses.valueInt() * 200;
  }

  bool canNew() {
    return isNew;
  }

  save(int id) {
    String query = """
    update persoanal_bal set
    month_exp = ${expenses.valueInt()}, repl_val = ${value.valueInt()},
    repl_ass = '${rep_assets.value()}', repl_val_ass = ${asset_value.valueInt()}
    where Profile_id = $id
    """;

    return query;
  }

  setValue(dynamic data) {
    expenses.setValue(data['month_exp']);
    value.setValue(data['repl_val']);
    rep_assets.setValue(data['repl_ass']);
    asset_value.setValue(data['repl_val_ass']);
  }

  builder() {
    TextStyle style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
    );
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
          expenses.builder(),
          value.builder(),
          rep_assets.builder(),
          asset_value.builder(),
          ListTile(
            title: Text("Total Requirement"),
            subtitle: const Text("Monthly Expenses * 200"),
            trailing: Text(totalRequirement().toString()),
          ),
          ListTile(
            leading: Text("Deficit / Surplus"),
            trailing: Text(calculate().toString()),
          ),
        ],
      ),
    );
  }
}
