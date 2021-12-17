import 'package:finance_app/Helpers/text_form_field_helper.dart';
import 'package:finance_app/Models/balance_model.dart';
import 'package:flutter/material.dart';

class ParentWell extends BalanceModel {
  Input expenses = Input.number(label: "Well being Expenses");
  Input value = Input.number(label: "Well being  Value");
  Input rep_assets = Input(label: "Well being value Assets");
  Input asset_value = Input.number(label: "Well being value in Lakhs");

  String heading = "Parents Well Being Expenses";
  bool isNew = false;

  double calculate() {
    double val = asset_value.valueInt() - value.valueInt();
    return val;
  }

  save(int id) {
    String query = """
    update persoanal_bal set
    parents_exp = ${expenses.valueInt()},parents_exp_val = ${value.valueInt()},
    parents_exp_ass = '${rep_assets.value()}',parents_exp_ass_val = ${asset_value.valueInt()}
    where Profile_id = $id
    """;
    return query;
  }

  setValue(dynamic data) {
    expenses.setValue(data['parents_exp']);
    value.setValue(data['parents_exp_val']);
    rep_assets.setValue(data['parents_exp_ass']);
    asset_value.setValue(data['parents_exp_ass_val']);
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
        ],
      ),
    );
  }
}
