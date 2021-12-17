import 'package:finance_app/Helpers/text_form_field_helper.dart';
import 'package:finance_app/Models/balance_model.dart';
import 'package:flutter/material.dart';

class PassivIncome extends BalanceModel {
  Input value = Input.number(label: "fund Value");
  Input rep_assets = Input(label: "fund Assets");
  Input asset_value = Input.number(label: "fund value in Lakhs");

  String heading = "Guaranteeed Passive Invcome Fund";
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
    Guaranteed_amt = ${value.valueInt()},
    Guaranteed_ass = '${rep_assets.value()}',Guaranteed_ass_val = ${asset_value.valueInt()}
    where Profile_id = $id
    """;
    return query;
  }

  setValue(dynamic data) {
    value.setValue(data['Guaranteed_amt']);
    rep_assets.setValue(data['Guaranteed_ass']);
    asset_value.setValue(data['Guaranteed_ass_val']);
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
          value.builder(),
          rep_assets.builder(),
          asset_value.builder(),
        ],
      ),
    );
  }
}
