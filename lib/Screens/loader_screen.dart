import 'package:finance_app/Helpers/querie.dart';
import 'package:finance_app/Helpers/show_snakebar.dart';
import 'package:finance_app/Providers/main_provider.dart';
import 'package:finance_app/Screens/dashboard.dart';
import 'package:finance_app/Screens/welcome_screen.dart';
import 'package:finance_app/Services/loader_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoaderScreen extends StatefulWidget {
  const LoaderScreen({Key? key}) : super(key: key);

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  start() async {
    try {
      final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      final String? id = prefs.getString('id');
      final String? pass = prefs.getString('pass');
      if (id != null) {
        dynamic result = await Query.execute(
            query:
                "select top 1 * from usr_mast where mobile = $id and pwd = $pass");
        Provider.of<MainProvider>(context, listen: false).setData(result[0]);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
        );
        showSnakeBar(context, "Welcome Back");
      } else {
        throw "Welcome";
      }
    } catch (e) {
      showSnakeBar(context, "You Need To Login/Signup To Application");
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'),
            const SizedBox(
              height: 10,
            ),
            Loader.circular,
          ],
        ),
      ),
    );
  }
}
