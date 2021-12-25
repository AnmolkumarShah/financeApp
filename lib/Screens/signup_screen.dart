import 'package:finance_app/Helpers/date_selected_helper.dart';
import 'package:finance_app/Helpers/querie.dart';
import 'package:finance_app/Helpers/show_snakebar.dart';
import 'package:finance_app/Helpers/text_form_field_helper.dart';
import 'package:finance_app/Providers/main_provider.dart';
import 'package:finance_app/Screens/dashboard.dart';
import 'package:finance_app/Services/loader_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  dynamic data;
  SignUpScreen({Key? key, this.data}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final Input _name = Input(label: "Name");
  final Input _password = Input.password(label: "Password");
  final Input _mobile = Input.number(label: "Mobile Number");
  final Input _email = Input.email(label: "Email");
  final MyDate _dob = MyDate(label: "DOB");

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  bool loading = false;

  save() async {
    setState(() {
      loading = true;
    });
    if (_form.currentState!.validate()) {
      try {
        List<dynamic> multicheck = await Query.execute(
            query: "select * from usr_mast where mobile = ${_mobile.value()}");
        if (multicheck.isNotEmpty) {
          throw "This Mobile Number Has Already Been Registered, Try With Different Number";
        }
        if (_dob.value() == DateTime(1900)) {
          throw "Please Select A Valid Date";
        }
        List<dynamic> pre =
            await Query.execute(query: "select * from usr_mast");
        final _id = pre.length + 1;
        dynamic result = await Query.execute(
          p1: '1',
          query: '''
        insert into usr_mast(id,usr_nm,pwd,mobile,email,dob)
        values($_id,'${_name.value()}','${_password.value()}','${_mobile.value()}',
        '${_email.value()}','${_dob.formatValue()}'
        )
        ''',
        );
        print(result);
        if (result['status'] == 'success') {
          final Future<SharedPreferences> _prefs =
              SharedPreferences.getInstance();
          final SharedPreferences prefs = await _prefs;
          //
          await prefs.setString('id', _mobile.value());
          await prefs.setString('pass', _password.value());
          //
          dynamic result = await Query.execute(
              query: "select top 1 * from usr_mast where id = $_id");
          Provider.of<MainProvider>(context, listen: false).setData(result[0]);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Dashboard(),
            ),
          );
          showSnakeBar(context, "Your Registration Done Successfully");
        } else {
          throw "Error Occured while Registration";
        }
      } catch (e) {
        print(e);
        showSnakeBar(context, e.toString());
      }
    } else {
      showSnakeBar(context, "Please Enter All Fields Properly");
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
      dynamic result = await Query.execute(
        p1: '1',
        query: '''
          update usr_mast
          set usr_nm = '${_name.value()}', pwd = '${_password.value()}',          
          mobile = '${_mobile.value()}', email = '${_email.value()}',
          dob = '${_dob.formatValue()}'         
        ''',
      );
      dynamic res = await Query.execute(
          query:
              "select top 1 * from usr_mast where id = ${widget.data['id']}");
      Provider.of<MainProvider>(context, listen: false).setData(res[0]);
      if (result['status'] == 'success') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
        );
        showSnakeBar(context, "Updated Successfully");
      } else {
        throw "Error Occured while Updating";
      }
    } catch (e) {
      print(e);
      showSnakeBar(context, e.toString());
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    if (widget.data != null) {
      final data = widget.data;
      _name.setValue(data['usr_nm']);
      _password.setValue(data['pwd']);

      _mobile.setValue(data['mobile']);
      _email.setValue(data['email']);
      _dob.setValue(data['dob']);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _form,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/logo.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            _name.builder(),
            _password.builder(),
            _mobile.builder(),
            _email.builder(),
            _dob.builder(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: loading == true
                  ? Loader.circular
                  : widget.data != null
                      ? ElevatedButton.icon(
                          icon: const Icon(Icons.update),
                          onPressed: update,
                          label: const Text("Update"),
                        )
                      : ElevatedButton.icon(
                          icon: const Icon(Icons.next_plan_outlined),
                          onPressed: save,
                          label: const Text("Save"),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
