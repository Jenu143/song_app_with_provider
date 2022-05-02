import 'package:flutter/material.dart';

Future commanLoder(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}

void screenBack(BuildContext context) {
  return Navigator.of(context).pop();
}
