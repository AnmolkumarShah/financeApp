import 'package:finance_app/Helpers/querie.dart';
import 'package:finance_app/Helpers/show_snakebar.dart';
import 'package:finance_app/Helpers/text_form_field_helper.dart';
import 'package:finance_app/Providers/main_provider.dart';
import 'package:finance_app/Services/loader_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SavingScreen extends StatefulWidget {
  SavingScreen({Key? key}) : super(key: key);

  @override
  State<SavingScreen> createState() => _SavingScreenState();
}

class _SavingScreenState extends State<SavingScreen> {
  final Input cash_bank = Input.number(label: "Cash/Bank");

  final Input bond_gov = Input.number(label: "Bonds/Govt Sec");

  final Input mutualfunds = Input.number(label: "Mutual Funds");

  final Input fd_rd = Input.number(label: "FD/RD");

  final Input ppf_epf = Input.number(label: "PPF/EPF");

  final Input insurance = Input.number(label: "Insurance");

  final Input equity_share = Input.number(label: "Equities/ Shares");

  final Input real_estate = Input.number(label: "Real Estate");

  final Input gold = Input.number(label: "Gold");

  final Input other = Input.number(label: "Any Other");

  double totalValue() {
    double tot = double.parse(cash_bank.value()) +
        double.parse(bond_gov.value()) +
        double.parse(mutualfunds.value()) +
        double.parse(fd_rd.value()) +
        double.parse(ppf_epf.value()) +
        double.parse(insurance.value()) +
        double.parse(equity_share.value()) +
        double.parse(real_estate.value()) +
        double.parse(gold.value()) +
        double.parse(other.value());
    return tot;
  }

  bool loading = false;
  bool isUpdateon = false;

  static int count = 0;

  @override
  void initState() {
    super.initState();
    count = 0;
  }

  @override
  void dispose() {
    super.dispose();
    count = 0;
  }

  save() async {
    try {
      setState(() {
        loading = true;
      });
      dynamic data =
          Provider.of<MainProvider>(context, listen: false).getData();
      int id = data['id'];
      dynamic result = await Query.execute(p1: '1', query: '''
      insert into savings(Profile_id,amt,bonds,mutual_funds,fd,ppf,insurance, 
      equities,real_estate,gold,other,tamt)
      values($id,${cash_bank.valueInt()},${bond_gov.valueInt()},${mutualfunds.valueInt()},
      ${fd_rd.valueInt()},${ppf_epf.valueInt()},${insurance.valueInt()},
      ${equity_share.valueInt()},${real_estate.valueInt()},${gold.valueInt()},
      ${other.valueInt()},${totalValue()})
      ''');
      print(result);
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
      update savings
      set amt = ${cash_bank.valueInt()},bonds = ${bond_gov.valueInt()},
      mutual_funds = ${mutualfunds.valueInt()},fd = ${fd_rd.valueInt()},
      ppf = ${ppf_epf.valueInt()},insurance = ${insurance.valueInt()},
      equities = ${equity_share.valueInt()},real_estate = ${real_estate.valueInt()},
      gold = ${gold.valueInt()},other = ${other.valueInt()},
      tamt = ${totalValue()}      
      where Profile_id = $id
      ''');
      print(result);
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
        query: 'select top 1 * from savings where Profile_id = $id');
    print(res);
    if (res!.isNotEmpty) {
      cash_bank.setValue(res![0]['amt'].toString());
      bond_gov.setValue(res![0]['bonds'].toString());
      mutualfunds.setValue(res![0]['mutual_funds'].toString());
      fd_rd.setValue(res![0]['fd'].toString());
      ppf_epf.setValue(res![0]['ppf'].toString());
      insurance.setValue(res![0]['insurance'].toString());
      equity_share.setValue(res![0]['equities'].toString());
      real_estate.setValue(res![0]['real_estate'].toString());
      gold.setValue(res![0]['gold'].toString());
      other.setValue(res![0]['other'].toString());
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Savings"),
      ),
      body: FutureBuilder(
          future: init(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loader.circular;
            }
            return ListView(
              children: [
                cash_bank.builder(),
                bond_gov.builder(),
                mutualfunds.builder(),
                fd_rd.builder(),
                ppf_epf.builder(),
                insurance.builder(),
                equity_share.builder(),
                real_estate.builder(),
                gold.builder(),
                other.builder(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: loading == true
                      ? Loader.circular
                      : isUpdateon == true
                          ? ElevatedButton.icon(
                              onPressed: () async {
                                await update();
                                List<_PieData> data = [
                                  _PieData(cash_bank.label(),
                                      double.parse(cash_bank.value())),
                                  _PieData(bond_gov.label(),
                                      double.parse(bond_gov.value())),
                                  _PieData(mutualfunds.label(),
                                      double.parse(mutualfunds.value())),
                                  _PieData(fd_rd.label(),
                                      double.parse(fd_rd.value())),
                                  _PieData(ppf_epf.label(),
                                      double.parse(ppf_epf.value())),
                                  _PieData(insurance.label(),
                                      double.parse(insurance.value())),
                                  _PieData(equity_share.label(),
                                      double.parse(equity_share.value())),
                                  _PieData(real_estate.label(),
                                      double.parse(real_estate.value())),
                                  _PieData(
                                      gold.label(), double.parse(gold.value())),
                                  _PieData(other.label(),
                                      double.parse(other.value())),
                                ];
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return PieChart(
                                      data: data,
                                      totalValue: totalValue(),
                                    );
                                  },
                                );
                              },
                              label: const Text("Update"),
                              icon: const Icon(Icons.system_update_alt),
                            )
                          : ElevatedButton.icon(
                              onPressed: () async {
                                await save();
                                List<_PieData> data = [
                                  _PieData(cash_bank.label(),
                                      double.parse(cash_bank.value())),
                                  _PieData(bond_gov.label(),
                                      double.parse(bond_gov.value())),
                                  _PieData(mutualfunds.label(),
                                      double.parse(mutualfunds.value())),
                                  _PieData(fd_rd.label(),
                                      double.parse(fd_rd.value())),
                                  _PieData(ppf_epf.label(),
                                      double.parse(ppf_epf.value())),
                                  _PieData(insurance.label(),
                                      double.parse(insurance.value())),
                                  _PieData(equity_share.label(),
                                      double.parse(equity_share.value())),
                                  _PieData(real_estate.label(),
                                      double.parse(real_estate.value())),
                                  _PieData(
                                      gold.label(), double.parse(gold.value())),
                                  _PieData(other.label(),
                                      double.parse(other.value())),
                                ];
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return PieChart(
                                      data: data,
                                      totalValue: totalValue(),
                                    );
                                  },
                                );
                              },
                              label: const Text("Save"),
                              icon: const Icon(Icons.save_sharp),
                            ),
                )
              ],
            );
          }),
    );
  }
}

class PieChart extends StatefulWidget {
  List<_PieData>? data;
  double? totalValue;
  PieChart({Key? key, this.data, this.totalValue}) : super(key: key);

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  int perc(String val) {
    return ((double.parse(val) / widget.totalValue!) * 100).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListTile(
            title: const Text("Total Saving"),
            subtitle: Text(widget.totalValue.toString()),
          ),
          SfCircularChart(
            title: ChartTitle(text: 'Your Savings Chart'),
            series: <PieSeries<_PieData, String>>[
              PieSeries<_PieData, String>(
                dataSource: widget.data,
                strokeWidth: 1,
                strokeColor: Colors.black,
                xValueMapper: (_PieData data, _) => data.xData,
                yValueMapper: (_PieData data, _) => data.yData,
                dataLabelMapper: (_PieData data, _) =>
                    "${perc(data.yData.toString())}% " + data.xData,
                radius: '75%',
                startAngle: 80,
                endAngle: 80,
                groupMode: CircularChartGroupMode.value,
                dataLabelSettings: const DataLabelSettings(
                  showZeroValue: false,
                  isVisible: true,
                  labelIntersectAction: LabelIntersectAction.shift,
                  labelPosition: ChartDataLabelPosition.outside,
                  borderRadius: 5,
                  connectorLineSettings:
                      ConnectorLineSettings(type: ConnectorType.curve),
                ),
              )
            ],
            tooltipBehavior: TooltipBehavior(enable: true),
          ),
        ],
      ),
    );
  }
}

class _PieData {
  _PieData(this.xData, this.yData);
  final String xData;
  final num yData;
}
