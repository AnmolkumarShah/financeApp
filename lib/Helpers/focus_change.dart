import 'package:flutter/material.dart';

class FocusChange extends StatelessWidget {
  FocusChange({Key? key, this.widget, this.callback}) : super(key: key);
  Widget? widget;
  Function? callback;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: widget!,
      onFocusChange: (bool val) {
        if (val == false) {
          callback!();
        }
      },
    );
  }
}
