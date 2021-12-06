import 'package:finance_app/Helpers/text_form_field_helper.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SavingScreen extends StatelessWidget {
  SavingScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Savings"),
      ),
      body: ListView(
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
            child: ElevatedButton(
              onPressed: () {
                List<_PieData> data = [
                  _PieData(cash_bank.label(), int.parse(cash_bank.value())),
                  _PieData(bond_gov.label(), int.parse(bond_gov.value())),
                  _PieData(mutualfunds.label(), int.parse(mutualfunds.value())),
                  _PieData(fd_rd.label(), int.parse(fd_rd.value())),
                  _PieData(ppf_epf.label(), int.parse(ppf_epf.value())),
                  _PieData(insurance.label(), int.parse(insurance.value())),
                  _PieData(
                      equity_share.label(), int.parse(equity_share.value())),
                  _PieData(real_estate.label(), int.parse(real_estate.value())),
                  _PieData(gold.label(), int.parse(gold.value())),
                  _PieData(other.label(), int.parse(other.value())),
                ];
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return PieChart(
                      data: data,
                    );
                  },
                );
              },
              child: const Text("Save"),
            ),
          )
        ],
      ),
    );
  }
}

class PieChart extends StatefulWidget {
  List<_PieData>? data;
  PieChart({Key? key, this.data}) : super(key: key);

  @override
  _PieChartState createState() => _PieChartState();
}

class _PieChartState extends State<PieChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SfCircularChart(
      title: ChartTitle(text: 'Your Savings'),
      series: <PieSeries<_PieData, String>>[
        PieSeries<_PieData, String>(
            dataSource: widget.data,
            xValueMapper: (_PieData data, _) => data.xData,
            yValueMapper: (_PieData data, _) => data.yData,
            dataLabelMapper: (_PieData data, _) => data.xData,
            radius: '55%',
            startAngle: 80,
            endAngle: 80,
            dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelIntersectAction: LabelIntersectAction.none,
                labelPosition: ChartDataLabelPosition.outside,
                connectorLineSettings:
                    ConnectorLineSettings(type: ConnectorType.curve)))
      ],
      tooltipBehavior: TooltipBehavior(enable: true),
    ));
  }
}

class _PieData {
  _PieData(this.xData, this.yData);
  final String xData;
  final num yData;
}
