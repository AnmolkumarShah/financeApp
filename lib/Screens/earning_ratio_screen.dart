import 'package:finance_app/Helpers/querie.dart';
import 'package:finance_app/Providers/main_provider.dart';
import 'package:finance_app/Screens/dashboard.dart';
import 'package:finance_app/Screens/earning_screen.dart';
import 'package:finance_app/Screens/savings_screen.dart';
import 'package:finance_app/Services/loader_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EarningratioScreen extends StatefulWidget {
  const EarningratioScreen({Key? key}) : super(key: key);

  @override
  State<EarningratioScreen> createState() => _EarningratioScreenState();
}

class _EarningratioScreenState extends State<EarningratioScreen> {
  @override
  Widget build(BuildContext context) {
    getSet() async {
      try {
        double totalEarning = 0;
        double totalSaving = 0;
        dynamic data =
            Provider.of<MainProvider>(context, listen: false).getData();
        int _id = data['id'];
        List<dynamic> res1 = await Query.execute(
            query: "select * from  earning where Profile_id = $_id");
        if (res1.isEmpty) {
          throw "Please Fill Details In Earning Section First";
        }
        totalEarning += res1[0]['amt1'] +
            res1[0]['amt2'] +
            res1[0]['amt3'] +
            res1[0]['amt4'] +
            res1[0]['amt5'] +
            res1[0]['amt6'] +
            res1[0]['amt7'] +
            res1[0]['amt8'] +
            res1[0]['amt9'] +
            res1[0]['amt10'];
        List<dynamic> res2 = await Query.execute(
            query: "select tamt from  savings where Profile_id = $_id");

        if (res2.isEmpty) {
          throw "Please Fill Details In Saving Section Also";
        }
        totalSaving = res2[0]['tamt'];

        if (totalEarning == 0) {
          throw "Your Total Earning is Zero, Please Fill It First";
        } else if (totalSaving == 0) {
          throw "Your Total Savings is Zero, Please Fill It First";
        } else {
          return "Your Saving Ratio is ${(totalSaving / totalEarning).toStringAsFixed(2)}";
        }
      } catch (e) {
        return e;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("My Saving Ratio"),
      ),
      body: ListView(
        children: [
          dashboard_tile(
            icondata: Icons.stars_outlined,
            label: "Savings",
            fun: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavingScreen(),
                ),
              );
              setState(() {});
            },
          ),
          dashboard_tile(
            icondata: Icons.payment,
            label: "Earnings",
            fun: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EarningScreen(),
                ),
              );
              setState(() {});
            },
          ),
          ListTile(
            title: FutureBuilder(
              future: getSet(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loader.circular;
                }
                dynamic data = snapshot.data;
                return ListTile(
                  tileColor: Colors.amber,
                  leading: Icon(Icons.featured_play_list_outlined),
                  title: Text(
                    data,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
