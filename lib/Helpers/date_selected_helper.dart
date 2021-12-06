import 'package:finance_app/Helpers/date_format_from_data_base.dart';
import 'package:finance_app/Helpers/field_cover.dart';
import 'package:finance_app/Helpers/format_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DateHelper extends StatefulWidget {
  Function? fun;
  String? label;
  DateTime? givenDate;
  DateHelper({Key? key, this.fun, this.label, this.givenDate})
      : super(key: key);

  @override
  State<DateHelper> createState() => _DateHelperState();
}

class _DateHelperState extends State<DateHelper> {
  DateTime? _selectedDate = DateTime(1900);

  DateTime value() {
    return _selectedDate!;
  }

  @override
  void initState() {
    super.initState();
    if (widget.givenDate != DateTime(1900)) {
      _selectedDate = widget.givenDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return fieldcover(
      child: _selectedDate != DateTime(1900)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat.yMMMMEEEEd().format(_selectedDate!)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(1900);
                    });
                    widget.fun!(DateTime(1900));
                  },
                  icon: const Icon(Icons.cancel),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.label!),
                IconButton(
                  onPressed: () async {
                    final DateTime? val = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2050),
                    );
                    setState(() {
                      _selectedDate = val;
                    });
                    widget.fun!(val);
                  },
                  icon: const Icon(Icons.calendar_today_outlined),
                ),
              ],
            ),
    );
  }
}

class MyDate {
  DateTime? _value = DateTime(1900);
  String? label;

  MyDate({this.label = 'Select Date'});

  changeDate(DateTime? d) {
    _value = d;
  }

  DateTime value() {
    return _value!;
  }

  String formatValue() {
    return formateDate(value());
  }

  setValue(String val) {
    DateTime date = onlyDateFromDataBase(val);
    _value = date;
  }

  bool isEmpty() {
    return _value == DateTime(1900) ? true : false;
  }

  Widget builder() {
    return DateHelper(
      fun: changeDate,
      label: label,
      givenDate: _value,
    );
  }
}
