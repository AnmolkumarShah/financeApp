import 'package:finance_app/Helpers/text_form_field_helper.dart';
import 'package:finance_app/Models/balance_model.dart';
import 'package:flutter/material.dart';

class PersonalLoans extends BalanceModel {
  Input details = Input(label: "Loan details");
  Input value = Input.number(label: "Loan Value");
  Input assets = Input(label: "Loan Assets");
  Input asset_value = Input.number(label: "Loan Value in Lakhs");

  String heading = "Personal Outstanding Loans";
  bool isNew = false;

  double calculate() {
    double val = asset_value.valueInt() - value.valueInt();
    return val;
  }

  bool canNew() {
    return isNew;
  }

  save(int id) {
    String query = """
    update persoanal_bal set
    out_ln = '${details.value()}',out_amt = ${value.valueInt()},
    out_ass = '${assets.value()}',out_ass_val = ${asset_value.valueInt()}
    where Profile_id = $id
    """;
    return query;
  }

  setValue(dynamic data) {
    details.setValue(data['out_ln']);
    value.setValue(data['out_amt']);
    assets.setValue(data['out_ass']);
    asset_value.setValue(data['out_ass_val']);
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
          details.builder(),
          value.builder(),
          assets.builder(),
          asset_value.builder(),
          ListTile(
            leading: Text("Deficit / Surplus"),
            trailing: Text(calculate().toString()),
          ),
        ],
      ),
    );
  }
}
