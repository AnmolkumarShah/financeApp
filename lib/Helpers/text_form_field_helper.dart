import 'package:finance_app/Helpers/field_cover.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class TextFormHelper extends StatelessWidget {
  const TextFormHelper({
    Key? key,
    this.label,
    this.obscure,
    this.controller,
    this.type,
    this.validator,
    this.enable = true,
  }) : super(key: key);

  final String? label;
  final TextEditingController? controller;
  final bool? obscure;
  final TextInputType? type;
  final dynamic validator;

  final bool enable;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enable,
      validator: validator,
      controller: controller,
      obscureText: obscure!,
      keyboardType: type,
      decoration: InputDecoration(
        label: Text(label!),
        border: InputBorder.none,
      ),
    );
  }
}

class Input {
  TextEditingController? _controller;
  String? _label;
  TextInputType? _inputType;
  bool? _obscure;
  dynamic validator;

  bool enable = true;

  Input({String? label = "Placeholder"}) {
    _controller = TextEditingController(text: "");
    _label = label;
    _inputType = TextInputType.name;
    _obscure = false;
    validator = ValidationBuilder().minLength(3).required().build();
  }

  Input.notreq({String? label = "Placeholder"}) {
    _controller = TextEditingController(text: "");
    _label = label;
    _inputType = TextInputType.name;
    _obscure = false;
    validator = null;
  }

  Input.password({String? label = "Placeholder"}) {
    _controller = TextEditingController(text: "");
    _label = label;
    _inputType = TextInputType.visiblePassword;
    _obscure = true;
    validator = ValidationBuilder().minLength(6).required().build();
  }

  Input.number({String? label = "Placeholder"}) {
    _controller = TextEditingController(text: "0");
    _label = label;
    _inputType = TextInputType.number;
    _obscure = false;
    validator = ValidationBuilder().minLength(10).required().build();
  }

  Input.multiline({String? label = "Placeholder"}) {
    _controller = TextEditingController(text: "");
    _label = label;
    _inputType = TextInputType.multiline;
    _obscure = false;
    validator = ValidationBuilder().minLength(5).required().build();
  }

  Input.email({String? label = "Placeholder"}) {
    _controller = TextEditingController(text: "");
    _label = label;
    _inputType = TextInputType.emailAddress;
    _obscure = false;
    validator = ValidationBuilder().email().required().build();
  }

  Input.nonMutable({String? label = "Placeholder"}) {
    _controller = TextEditingController(text: "");
    _label = label;
    _inputType = TextInputType.text;
    _obscure = false;
    validator = null;
    enable = false;
  }

  Widget builder() {
    return fieldcover(
      child: TextFormHelper(
        label: _label,
        controller: _controller,
        obscure: _obscure,
        type: _inputType,
        validator: validator,
        enable: enable,
      ),
    );
  }

  String value() {
    return _controller!.value.text.trim();
  }

  double valueInt() {
    if (_controller!.value.text == '') return 0;
    return double.parse(_controller!.value.text.trim());
  }

  String label() {
    return _label!;
  }

  void setValue(dynamic val) {
    val = val.toString();
    _controller = TextEditingController(text: val.split('.')[0]);
  }

  TextEditingController getController() {
    return _controller!;
  }

  bool isEmpty() {
    return _controller!.value.text.trim().isEmpty ? true : false;
  }
}
