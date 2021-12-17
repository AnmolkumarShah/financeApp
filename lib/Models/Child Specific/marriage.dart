import 'package:finance_app/Helpers/focus_change.dart';
import 'package:finance_app/Helpers/text_form_field_helper.dart';
import 'package:flutter/material.dart';

import 'for_child.dart';

class ChildMarriage extends ForChild {
  Input year = Input.number(label: "Year");
  String heading = "Child Marriage";

  String q_yr = "ch_marr_yr";
  String q_amt = "ch_marr_val";
  String q_i_detail = "ch_marr_ass";
  String q_value = "ch_marr_val_ass";

  ChildMarriage({required int num, dynamic data}) {
    number = num;
    super.data = data;
    if (num == 1) {
      super.name = data['ch_name'];
    } else {
      super.name = data['ch_name1'];
      q_yr += '1';
      q_amt += '1';
      q_i_detail += '1';
      q_value += '1';
    }
    functionOnAmount();
    heading = "${name!.split(' ')[0]}'s Marriage";
  }
  @override
  copy() {
    if (number > 1) {
      throw "You Cannot Add More Than 2 Child";
    }
    ForChild temp = new ChildMarriage(num: number + 1, data: data);
    return temp;
  }

  builder() {
    TextStyle style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
    );

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
          year.builder(),
          FocusChange(
            widget: amount.builder(),
            callback: functionOnAmount,
          ),
          currInvestmentDetails.builder(),
          FocusChange(
            widget: currInvestmentValue.builder(),
            callback: functionOnAmount,
          ),
        ],
      ),
    );
  }

  @override
  save(int id) {
    String query = """
        update persoanal_bal set
        $q_yr = ${year.valueInt()}, $q_amt = ${amount.valueInt()},
        $q_i_detail = '${currInvestmentDetails.value()}',
        $q_value = ${currInvestmentValue.valueInt()}
        where Profile_id = $id        
        """;
    return query;
  }

  setValue(dynamic data) {
    year.setValue(data[q_yr]);
    amount.setValue(data[q_amt]);
    details.setValue(data[q_i_detail]);
    currInvestmentDetails.setValue(data[q_i_detail]);
    currInvestmentValue.setValue(data[q_value]);
  }
}
