import 'package:finance_app/Helpers/drop_down_helper.dart';
import 'package:finance_app/Helpers/text_form_field_helper.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({Key? key}) : super(key: key);

  @override
  State<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  List<Year> years = [
    for (var i = 2010; i <= DateTime.now().year; i++) Year(i, i)
  ];

  final Input _amt1 = Input.number(label: "Amount 1");
  Year? selectedYr1;

  final Input _amt2 = Input.number(label: "Amount 2");
  Year? selectedYr2;

  final Input _amt3 = Input.number(label: "Amount 3");
  Year? selectedYr3;

  final Input _amt4 = Input.number(label: "Amount 4");
  Year? selectedYr4;

  final Input _amt5 = Input.number(label: "Amount 5");
  Year? selectedYr5;

  final Input _amt6 = Input.number(label: "Amount 6");
  Year? selectedYr6;

  final Input _amt7 = Input.number(label: "Amount 7");
  Year? selectedYr7;

  final Input _amt8 = Input.number(label: "Amount 8");
  Year? selectedYr8;

  final Input _amt9 = Input.number(label: "Amount 9");
  Year? selectedYr9;

  final Input _amt10 = Input.number(label: "Amount 10");
  Year? selectedYr10;

  @override
  void initState() {
    super.initState();
    selectedYr1 = years.last;
    selectedYr2 = years.last;
    selectedYr3 = years.last;
    selectedYr4 = years.last;
    selectedYr5 = years.last;
    selectedYr6 = years.last;
    selectedYr7 = years.last;
    selectedYr8 = years.last;
    selectedYr9 = years.last;
    selectedYr10 = years.last;
  }

  save() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Earning"),
      ),
      body: Form(
        child: ListView(
          children: [
            RowMaker(
              one: _amt1.builder(),
              two: Dropdown<Year>(
                items: years,
                label: "Select Year",
                selected: selectedYr1,
                fun: (val) {
                  setState(() {
                    selectedYr1 = val;
                  });
                },
              ).build(),
            ),
            RowMaker(
              one: _amt2.builder(),
              two: Dropdown<Year>(
                items: years,
                label: "Select Year",
                selected: selectedYr2,
                fun: (val) {
                  setState(() {
                    selectedYr2 = val;
                  });
                },
              ).build(),
            ),
            RowMaker(
              one: _amt3.builder(),
              two: Dropdown<Year>(
                items: years,
                label: "Select Year",
                selected: selectedYr3,
                fun: (val) {
                  setState(() {
                    selectedYr3 = val;
                  });
                },
              ).build(),
            ),
            RowMaker(
              one: _amt4.builder(),
              two: Dropdown<Year>(
                items: years,
                label: "Select Year",
                selected: selectedYr4,
                fun: (val) {
                  setState(() {
                    selectedYr4 = val;
                  });
                },
              ).build(),
            ),
            RowMaker(
              one: _amt5.builder(),
              two: Dropdown<Year>(
                items: years,
                label: "Select Year",
                selected: selectedYr5,
                fun: (val) {
                  setState(() {
                    selectedYr5 = val;
                  });
                },
              ).build(),
            ),
            RowMaker(
              one: _amt6.builder(),
              two: Dropdown<Year>(
                items: years,
                label: "Select Year",
                selected: selectedYr6,
                fun: (val) {
                  setState(() {
                    selectedYr6 = val;
                  });
                },
              ).build(),
            ),
            RowMaker(
              one: _amt7.builder(),
              two: Dropdown<Year>(
                items: years,
                label: "Select Year",
                selected: selectedYr7,
                fun: (val) {
                  setState(() {
                    selectedYr7 = val;
                  });
                },
              ).build(),
            ),
            RowMaker(
              one: _amt8.builder(),
              two: Dropdown<Year>(
                items: years,
                label: "Select Year",
                selected: selectedYr8,
                fun: (val) {
                  setState(() {
                    selectedYr8 = val;
                  });
                },
              ).build(),
            ),
            RowMaker(
              one: _amt9.builder(),
              two: Dropdown<Year>(
                items: years,
                label: "Select Year",
                selected: selectedYr9,
                fun: (val) {
                  setState(() {
                    selectedYr9 = val;
                  });
                },
              ).build(),
            ),
            RowMaker(
              one: _amt10.builder(),
              two: Dropdown<Year>(
                items: years,
                label: "Select Year",
                selected: selectedYr10,
                fun: (val) {
                  setState(() {
                    selectedYr10 = val;
                  });
                },
              ).build(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  List<_ChartData> data = [
                    _ChartData(
                      selectedYr1!.year.toString(),
                      double.parse(_amt1.value()),
                    ),
                    _ChartData(
                      selectedYr2!.year.toString(),
                      double.parse(_amt2.value()),
                    ),
                    _ChartData(
                      selectedYr3!.year.toString(),
                      double.parse(_amt3.value()),
                    ),
                    _ChartData(
                      selectedYr4!.year.toString(),
                      double.parse(_amt4.value()),
                    ),
                    _ChartData(
                      selectedYr5!.year.toString(),
                      double.parse(_amt5.value()),
                    ),
                    _ChartData(
                      selectedYr6!.year.toString(),
                      double.parse(_amt6.value()),
                    ),
                    _ChartData(
                      selectedYr7!.year.toString(),
                      double.parse(_amt7.value()),
                    ),
                    _ChartData(
                      selectedYr8!.year.toString(),
                      double.parse(_amt8.value()),
                    ),
                    _ChartData(
                      selectedYr9!.year.toString(),
                      double.parse(_amt9.value()),
                    ),
                    _ChartData(
                      selectedYr10!.year.toString(),
                      double.parse(_amt10.value()),
                    ),
                  ];
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BarGraph(
                        data: data,
                      );
                    },
                  );
                },
                icon: const Icon(Icons.save_sharp),
                label: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Year {
  int? year;
  int? id;
  Year(this.year, this.id);
  String show() {
    return year!.toString();
  }
}

class BarGraph extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  BarGraph({Key? key, this.data}) : super(key: key);
  List<_ChartData>? data;
  @override
  BarGraphState createState() => BarGraphState();
}

class BarGraphState extends State<BarGraph> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  double max(List<_ChartData> data) {
    double maxVal = 0;
    for (var i = 0; i < data.length; i++) {
      if (data[i].y > maxVal) {
        maxVal = data[i].y;
      }
    }
    return maxVal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: max(widget.data!),
          interval: 10,
        ),
        tooltipBehavior: _tooltip,
        series: <ChartSeries<_ChartData, String>>[
          ColumnSeries<_ChartData, String>(
              dataSource: widget.data!,
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              name: 'Earning',
              color: const Color.fromRGBO(8, 142, 255, 1))
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
