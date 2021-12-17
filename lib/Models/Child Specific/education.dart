import 'package:finance_app/Helpers/date_format_from_data_base.dart';

import 'for_child.dart';

class ChildEducation extends ForChild {
  String q_amount = "ch_edu_amt";
  String q_detail = "ch_edu_detail";
  String q_asset = "ch_assets";
  String q_value = "ch_val";
  ChildEducation({required int num, dynamic data}) {
    super.number = num;
    super.data = data;
    functionOnAmount();
    if (num == 1) {
      super.name = data['ch_name'];
    } else {
      super.name = data['ch_name1'];
      q_amount += '1';
      q_detail += '1';
      q_asset += '1';
      q_value += '1';
    }
    heading = "${name!.split(' ')[0]}'s Education";
  }
  @override
  String heading = "Child Education";

  @override
  functionOnAmount() {
    int age;
    DateTime? bday;
    if (number == 1) {
      bday = onlyDateFromDataBase(data['chdt']);
    } else {
      bday = onlyDateFromDataBase(data['chdt1']);
    }
    age = DateTime.now().year - bday.year;
    int calc = 25 - age;
    double value;
    if (calc <= 0) {
      value = 0;
    }
    value = (25 - age) * 5;
    amount.setValue(value.toString());
    return super.functionOnAmount();
  }

  @override
  copy() {
    if (number > 1) {
      throw "You Cannot Add More Than 2 Child";
    }
    ForChild temp = new ChildEducation(num: number + 1, data: data);
    return temp;
  }

  @override
  save(int id) {
    String query = """
        update persoanal_bal set
        $q_amount = ${amount.valueInt()}, $q_detail = '${details.value()}',
        $q_asset = '${currInvestmentDetails.value()}', $q_value = ${currInvestmentValue.valueInt()}
        where Profile_id = $id        
        """;
    return query;
  }

  setValue(dynamic data) {
    amount.setValue(data[q_amount]);
    details.setValue(data[q_detail]);
    currInvestmentDetails.setValue(data[q_asset]);
    currInvestmentValue.setValue(data[q_value]);
  }
}
