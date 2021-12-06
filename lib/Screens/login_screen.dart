import 'package:finance_app/Helpers/querie.dart';
import 'package:finance_app/Helpers/show_snakebar.dart';
import 'package:finance_app/Helpers/text_form_field_helper.dart';
import 'package:finance_app/Providers/main_provider.dart';
import 'package:finance_app/Screens/dashboard.dart';
import 'package:finance_app/Services/loader_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Input _id = Input.number(label: "Registered Mobile Numner");

  final Input _pass = Input.password(label: "Password");

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool loading = false;

  login() async {
    setState(() {
      loading = true;
    });
    if (_form.currentState!.validate()) {
      dynamic result = await Query.execute(
          query:
              "select top 1 * from usr_mast where mobile = '${_id.value()}' and pwd = '${_pass.value()}'");
      Provider.of<MainProvider>(context, listen: false).setData(result[0]);
      final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
      final SharedPreferences prefs = await _prefs;
      await prefs.setInt('id', result[0]['id']);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Dashboard(),
        ),
      );
    } else {
      showSnakeBar(context, "Please Fill All Fields Properly");
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      Image.asset('assets/logo.jpg'),
                      const SizedBox(
                        height: 50,
                      ),
                      _id.builder(),
                      _pass.builder(),
                      loading == true
                          ? Loader.circular
                          : ElevatedButton.icon(
                              onPressed: login,
                              icon: const Icon(Icons.login),
                              label: const Text("Login"),
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
