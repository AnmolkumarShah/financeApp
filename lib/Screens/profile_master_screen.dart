import 'package:finance_app/Helpers/date_selected_helper.dart';
import 'package:finance_app/Helpers/text_form_field_helper.dart';
import 'package:flutter/material.dart';

class ProfileMasterScreen extends StatefulWidget {
  const ProfileMasterScreen({Key? key}) : super(key: key);

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

  final Input _childName1 = Input.notreq(label: "Chile 1 Name");
  final MyDate _c1dob = MyDate(label: "Child 1 DOB");

  final Input _childName2 = Input.notreq(label: "Chile 2 Name");
  final MyDate _c2dob = MyDate(label: "Child 2 DOB");

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  save() {
    _form.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Master"),
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: [
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
              child: ElevatedButton(onPressed: save, child: const Text("Save")),
            )
          ],
        ),
      ),
    );
  }
}
