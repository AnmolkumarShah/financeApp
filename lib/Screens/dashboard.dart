import 'dart:ui';

import 'package:finance_app/Helpers/querie.dart';
import 'package:finance_app/Helpers/show_snakebar.dart';
import 'package:finance_app/Providers/main_provider.dart';
import 'package:finance_app/Screens/earning_ratio_screen.dart';
import 'package:finance_app/Screens/login_screen.dart';
import 'package:finance_app/Screens/personal_balance_sheet.dart';
import 'package:finance_app/Screens/profile_master_screen.dart';
import 'package:finance_app/Screens/quiz_screen.dart';
import 'package:finance_app/Services/loader_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  Widget extraWidget(dynamic data) {
    return FutureBuilder(
      future: Query.execute(
          query: 'select address,place from usr_mast where id = ${data['id']}'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loader.circularWhite;
        }
        dynamic data = snapshot.data;
        if (data[0]['address'] == '' || data[0]['place'] == '') {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Icon(Icons.dangerous_outlined, color: Colors.white),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Profile Not Compleated!!!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text("");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic data = Provider.of<MainProvider>(context, listen: false).getData();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome,",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              data['usr_nm'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Column(
          children: [
            const Spacer(),
            ListTile(
              title: const Text("Logout From Application"),
              leading: const Icon(Icons.logout),
              onTap: () async {
                final Future<SharedPreferences> _prefs =
                    SharedPreferences.getInstance();
                final SharedPreferences prefs = await _prefs;
                prefs.clear();
                showSnakeBar(context, "You Are Logout Of Application");
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            )
          ],
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          dashboard_tile(
            icondata: Icons.account_balance,
            label: "My Profile Page",
            extra: extraWidget(data),
            fun: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileMasterScreen(
                    data: data,
                  ),
                ),
              );
            },
          ),
          dashboard_tile(
            icondata: Icons.question_answer,
            label: "My Financial Health",
            fun: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(),
                  // builder: (context) => const QuizGivenScreen(),
                ),
              );
            },
          ),
          dashboard_tile(
            icondata: Icons.star_rate_outlined,
            label: "My Savings Ratio",
            fun: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EarningratioScreen(),
                ),
              );
            },
          ),
          dashboard_tile(
            icondata: Icons.account_balance,
            label: "My Personal Balance Sheet",
            fun: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonalBalanceSheet(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class dashboard_tile extends StatelessWidget {
  final String? label;
  final IconData? icondata;
  final Function? fun;
  final Widget? extra;
  const dashboard_tile({
    Key? key,
    this.label,
    this.icondata,
    this.fun,
    this.extra,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => fun!(),
      child: Card(
        child: Container(
          height: 100,
          color: Theme.of(context).primaryColor,
          child: Row(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Icon(
                    icondata,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        title: Text(
                          label!,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: extra != null
                            ? extra
                            : SizedBox(
                                width: 0,
                              ),
                      ),
                    ],
                  ),
                ),
                flex: 8,
              ),
            ],
          ),
        ),
        elevation: 8,
        margin: const EdgeInsets.all(10),
      ),
    );
  }
}
