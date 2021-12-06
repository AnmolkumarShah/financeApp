import 'dart:ui';

import 'package:finance_app/Providers/main_provider.dart';
import 'package:finance_app/Screens/earning_screen.dart';
import 'package:finance_app/Screens/profile_master_screen.dart';
import 'package:finance_app/Screens/quiz_screen.dart';
import 'package:finance_app/Screens/savings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic data = Provider.of<MainProvider>(context, listen: false).getData();
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black,
                      Colors.black,
                      Colors.indigoAccent,
                      Colors.indigoAccent,
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 80),
                height: 150,
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(
                        5.0,
                        5.0,
                      ),
                      blurRadius: 30.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome,",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data['usr_nm'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          dashboard_tile(
            icondata: Icons.account_balance,
            label: "Profile",
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
            label: "Financial\nHealth",
            fun: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuizScreen(),
                ),
              );
            },
          ),
          dashboard_tile(
            icondata: Icons.payment,
            label: "Earnings",
            fun: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EarningScreen(),
                ),
              );
            },
          ),
          dashboard_tile(
            icondata: Icons.stars_outlined,
            label: "Savings",
            fun: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SavingScreen(),
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
  const dashboard_tile({
    Key? key,
    this.label,
    this.icondata,
    this.fun,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => fun!(),
      child: Container(
        height: 130,
        margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(
                5.0,
                5.0,
              ),
              blurRadius: 30.0,
              spreadRadius: 2.0,
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Colors.indigo,
              Colors.indigo,
            ],
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icondata,
                color: Colors.blueGrey,
                size: 70,
              ),
            ),
            const SizedBox(
              width: 100,
            ),
            Text(
              label!,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 38,
                fontWeight: FontWeight.w800,
              ),
            )
          ],
        ),
      ),
    );
  }
}
