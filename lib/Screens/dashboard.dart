import 'dart:ui';

import 'package:finance_app/Screens/earning_screen.dart';
import 'package:finance_app/Screens/profile_master_screen.dart';
import 'package:finance_app/Screens/quiz_screen.dart';
import 'package:finance_app/Screens/savings_screen.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            dashboard_tile(
              icondata: Icons.account_balance,
              label: "Profile",
              fun: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileMasterScreen(),
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
        height: 150,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Colors.white, Colors.red],
          ),
        ),
        child: Row(
          children: [
            Icon(
              icondata,
              color: Colors.blueGrey,
              size: 110,
            ),
            Text(
              label!,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.blueGrey,
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
