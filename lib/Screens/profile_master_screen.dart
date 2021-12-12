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

class ProfileMasterScreen extends StatefulWidget {
  dynamic data;
  ProfileMasterScreen({Key? key, this.data}) : super(key: key);

  @override
  _ProfileMasterScreenState createState() => _ProfileMasterScreenState();
}

class _ProfileMasterScreenState extends State<ProfileMasterScreen> {
  final Input _name = Input(label: "Name");
  final Input _password = Input.password(label: "Password");
  final Input _address = Input.multiline(label: "Address");
  final Input _place = Input(label: "Place");
  final Input _mobile = Input.number(label: "Mobile Number");
  final Input _email = Input.email(label: "Email");
  final MyDate _dob = MyDate(label: "DOB");
  final MyDate _ma = MyDate(label: "Marrage Anniversary");

  final Input _spousename = Input.notreq(label: "Spouse Name");
  final MyDate _spousedob = MyDate(label: "Spouse DOB");

  final Input _childName1 = Input.notreq(label: "Child 1 Name");
  final MyDate _c1dob = MyDate(label: "Child 1 DOB");

  final Input _childName2 = Input.notreq(label: "Child 2 Name");
  final MyDate _c2dob = MyDate(label: "Child 2 DOB");

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
        List<dynamic> pre =
            await Query.execute(query: "select * from usr_mast");
        final _id = pre.length + 1;
        dynamic result = await Query.execute(
          p1: '1',
          query: '''
        insert into usr_mast(id,usr_nm,pwd,address,place,mobile,email,dob,madt,
        s_name,sdate,ch_name,chdt,ch_name1,chdt1)
        values($_id,'${_name.value()}','${_password.value()}','${_address.value()}',
        '${_place.value()}','${_mobile.value()}','${_email.value()}','${_dob.formatValue()}',
        '${_ma.formatValue()}','${_spousename.value()}','${_spousedob.formatValue()}',
        '${_childName1.value()}','${_c1dob.formatValue()}','${_childName2.value()}',
        '${_c2dob.formatValue()}')
        ''',
        );
        if (result['status'] == 'success') {
          final Future<SharedPreferences> _prefs =
              SharedPreferences.getInstance();
          final SharedPreferences prefs = await _prefs;
          await prefs.setInt('id', _id);
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
          address = '${_address.value()}', place = '${_place.value()}',
          mobile = '${_mobile.value()}', email = '${_email.value()}',
          dob = '${_dob.formatValue()}', madt = '${_ma.formatValue()}',
          s_name = '${_spousename.value()}',sdate = '${_spousedob.formatValue()}',
          ch_name = '${_childName1.value()}',chdt = '${_c1dob.formatValue()}',
          ch_name1 = '${_childName2.value()}',chdt1 = '${_c2dob.formatValue()}'
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
      _address.setValue(data['address']);
      _place.setValue(data['place']);
      _mobile.setValue(data['mobile']);
      _email.setValue(data['email']);
      _dob.setValue(data['dob']);
      _ma.setValue(data['madt']);

      _spousename.setValue(data['s_name']);
      _spousedob.setValue(data['sdate']);

      _childName1.setValue(data['ch_name']);
      _c1dob.setValue(data['chdt']);

      _childName2.setValue(data['ch_name1']);
      _c2dob.setValue(data['chdt1']);
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
            _address.builder(),
            _place.builder(),
            _mobile.builder(),
            _email.builder(),
            _dob.builder(),
            _ma.builder(),
            _spousename.builder(),
            _spousedob.builder(),
            _childName1.builder(),
            _c1dob.builder(),
            _childName2.builder(),
            _c2dob.builder(),
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
