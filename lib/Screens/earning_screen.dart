import 'package:finance_app/Helpers/drop_down_helper.dart';
import 'package:finance_app/Helpers/querie.dart';
import 'package:finance_app/Helpers/show_snakebar.dart';
import 'package:finance_app/Helpers/text_form_field_helper.dart';
import 'package:finance_app/Providers/main_provider.dart';
import 'package:finance_app/Services/loader_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  final Input _amt1 = Input.number(label: "Amount");
  Year? selectedYr1;

  final Input _amt2 = Input.number(label: "Amount");
  Year? selectedYr2;

  final Input _amt3 = Input.number(label: "Amount");
  Year? selectedYr3;

  final Input _amt4 = Input.number(label: "Amount");
  Year? selectedYr4;

  final Input _amt5 = Input.number(label: "Amount");
  Year? selectedYr5;

  final Input _amt6 = Input.number(label: "Amount");
  Year? selectedYr6;

  final Input _amt7 = Input.number(label: "Amount");
  Year? selectedYr7;

  final Input _amt8 = Input.number(label: "Amount");
  Year? selectedYr8;

  final Input _amt9 = Input.number(label: "Amount");
  Year? selectedYr9;

  final Input _amt10 = Input.number(label: "Amount");
  Year? selectedYr10;

  bool loading = false;

  static int count = 0;

  @override
  void initState() {
    super.initState();
    count = 0;
    selectedYr1 = years[years.length - 10];
    selectedYr2 = years[years.length - 9];
    selectedYr3 = years[years.length - 8];
    selectedYr4 = years[years.length - 7];
    selectedYr5 = years[years.length - 6];
    selectedYr6 = years[years.length - 5];
    selectedYr7 = years[years.length - 4];
    selectedYr8 = years[years.length - 3];
    selectedYr9 = years[years.length - 2];
    selectedYr10 = years[years.length - 1];
  }

  @override
  void dispose() {
    super.dispose();
    count = 0;
  }

  bool isUpdateon = false;

  save() async {
    try {
      setState(() {
        loading = true;
      });
      dynamic data =
          Provider.of<MainProvider>(context, listen: false).getData();
      int id = data['id'];
      dynamic result = await Query.execute(p1: '1', query: '''
      insert into earning(Profile_id,Year1,amt1, Year2,amt2, Year3,amt3, 
      Year4,amt4, Year5,amt5, Year6,amt6, Year7,amt7, Year8,amt8, Year9,amt9,
      Year10,amt10)
      values($id,${selectedYr1!.value()},${_amt1.valueInt()}, ${selectedYr2!.value()},${_amt2.valueInt()}, 
      ${selectedYr3!.value()},${_amt3.valueInt()},${selectedYr4!.value()},${_amt4.valueInt()}, ${selectedYr5!.value()},${_amt5.valueInt()}, 
      ${selectedYr6!.value()},${_amt6.valueInt()},${selectedYr7!.value()},${_amt7.valueInt()}, ${selectedYr8!.value()},${_amt8.valueInt()}, 
      ${selectedYr9!.value()},${_amt9.valueInt()},${selectedYr10!.value()},${_amt10.valueInt()})
      ''');

      if (result['status'] == 'success') {
        showSnakeBar(context, "Saved Successfully");
      } else {
        showSnakeBar(context, "Error In Saving");
      }
    } catch (e) {
      showSnakeBar(context, e.toString());
    }
    setState(() {
      loading = false;
    });
  }

  update() async {
    setState(() {
      loading = true;
    });
    try {
      dynamic data =
          Provider.of<MainProvider>(context, listen: false).getData();
      int id = data['id'];
      dynamic result = await Query.execute(p1: '1', query: '''
      update earning
      set Year1 = ${selectedYr1!.value()},  year2 = ${selectedYr2!.value()},
      year3 = ${selectedYr3!.value()},year4 = ${selectedYr4!.value()},
      year5 = ${selectedYr5!.value()},year6 = ${selectedYr6!.value()},
      year7 = ${selectedYr7!.value()},year8 = ${selectedYr8!.value()},
      year9 = ${selectedYr9!.value()},year10 = ${selectedYr10!.value()},

      amt1 = ${_amt1.valueInt()},amt2 = ${_amt2.valueInt()},
      amt3 = ${_amt3.valueInt()},amt4 = ${_amt4.valueInt()},
      amt5 = ${_amt5.valueInt()},amt6 = ${_amt6.valueInt()},
      amt7 = ${_amt7.valueInt()},amt8 = ${_amt8.valueInt()},
      amt9 = ${_amt9.valueInt()},amt10 = ${_amt10.valueInt()}

      where Profile_id = $id
      ''');
      if (result['status'] == 'success') {
        showSnakeBar(context, "Updated Successfully");
      } else {
        showSnakeBar(context, "Error In Saving");
      }
    } catch (e) {
      showSnakeBar(context, e.toString());
    }
    setState(() {
      loading = false;
    });
  }

  List<dynamic>? res;
  init() async {
    if (count > 0) return;
    dynamic data = Provider.of<MainProvider>(context, listen: false).getData();
    int id = data['id'];
    res = await Query.execute(
        query: 'select top 1 * from earning where Profile_id = $id');
    if (res!.isNotEmpty) {
      _amt1.setValue(res![0]['amt1'].toString());
      _amt2.setValue(res![0]['amt2'].toString());
      _amt3.setValue(res![0]['amt3'].toString());
      _amt4.setValue(res![0]['amt4'].toString());
      _amt5.setValue(res![0]['amt5'].toString());
      _amt6.setValue(res![0]['amt6'].toString());
      _amt7.setValue(res![0]['amt7'].toString());
      _amt8.setValue(res![0]['amt8'].toString());
      _amt9.setValue(res![0]['amt9'].toString());
      _amt10.setValue(res![0]['amt10'].toString());

      selectedYr1 = years.firstWhere((y) => y.value() == res![0]['Year1']);
      selectedYr2 = years.firstWhere((y) => y.value() == res![0]['year2']);
      selectedYr3 = years.firstWhere((y) => y.value() == res![0]['year3']);
      selectedYr4 = years.firstWhere((y) => y.value() == res![0]['year4']);
      selectedYr5 = years.firstWhere((y) => y.value() == res![0]['year5']);
      selectedYr6 = years.firstWhere((y) => y.value() == res![0]['year6']);
      selectedYr7 = years.firstWhere((y) => y.value() == res![0]['year7']);
      selectedYr8 = years.firstWhere((y) => y.value() == res![0]['year8']);
      selectedYr9 = years.firstWhere((y) => y.value() == res![0]['year9']);
      selectedYr10 = years.firstWhere((y) => y.value() == res![0]['year10']);
      setState(() {
        isUpdateon = true;
      });
      count++;
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      if (count > 0) return Future(() async {});
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text(
            "Please Enter Your Total Earnings For The Above Years.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            )
          ],
        ),
      );
    });

    showGraph(List<_ChartData>? data) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return BarGraph(
            data: data,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Earning"),
      ),
      body: FutureBuilder(
          future: init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader.shimmer;
            }

            return Form(
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
                    child: loading == true
                        ? Loader.circular
                        : isUpdateon == true
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      await update();
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
                                      showGraph(data);
                                    },
                                    icon: const Icon(Icons.system_update_alt),
                                    label: const Text("Update"),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () async {
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
                                      showGraph(data);
                                    },
                                    icon: const Icon(Icons.auto_graph),
                                    label: const Text("Show Graph"),
                                  ),
                                ],
                              )
                            : ElevatedButton.icon(
                                onPressed: () async {
                                  await save();
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
                                  showGraph(data);
                                },
                                icon: const Icon(Icons.save_sharp),
                                label: const Text("Save"),
                              ),
                  )
                ],
              ),
            );
          }),
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

  int value() {
    return year!;
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
