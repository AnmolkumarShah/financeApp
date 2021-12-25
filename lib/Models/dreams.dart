import 'package:finance_app/Helpers/text_form_field_helper.dart';
import 'package:finance_app/Models/balance_model.dart';
import 'package:flutter/material.dart';

class Dreams extends BalanceModel {
  int number = 1;
  Input year = Input.number(label: "Year");
  Input details = Input.number(label: "Details");
  Input value = Input.number(label: "Value");
  Input assets = Input(label: "Assets");
  Input other_dream = Input.number(label: "Value in Lakhs");

  String q_yr = "other_dr_yr";
  String q_detail = "other_dr_detail";
  String q_value = "other_dr_val";
  String q_ass = "other_dr_ass";
  String q_ass_val = "other_dr_ass_val";

  Dreams({required int num}) {
    number = num;
    heading += " #${number}";
    if (number > 1) {
      q_yr += "${number - 1}";
      q_detail += "${number - 1}";
      q_value += "${number - 1}";
      q_ass += "${number - 1}";
      q_ass_val += "${number - 1}";
    }
  }

  String heading = "Dream";
  bool isNew = true;

  double calculate() {
    double val = other_dream.valueInt() - value.valueInt();
    return val;
  }

  bool canNew() {
    return isNew;
  }

  Dreams copy() {
    if (number > 2) {
      throw "You Cannot Add More Than 3 Dreams";
    }
    Dreams temp = new Dreams(num: number + 1);
    return temp;
  }

  save(int id) {
    String query = """
    update persoanal_bal set
    $q_yr = ${year.valueInt()}, $q_detail = '${details.value()}',
    $q_value = ${value.valueInt()}, $q_ass = '${assets.value()}',
    $q_ass_val = ${other_dream.valueInt()}
    where Profile_id = $id
    """;
    return query;
  }

  setValue(dynamic data) {
    year.setValue(data[q_yr]);
    details.setValue(data[q_detail]);
    value.setValue(data[q_value]);
    assets.setValue(data[q_ass]);
    other_dream.setValue(data[q_ass_val]);
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
          year.builder(),
          details.builder(),
          value.builder(),
          assets.builder(),
          other_dream.builder(),
          ListTile(
            leading: Text("Deficit / Surplus"),
            trailing: Text(calculate().toString()),
          ),
        ],
      ),
    );
  }
}
