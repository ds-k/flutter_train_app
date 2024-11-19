import 'package:flutter/material.dart';

Widget label(String name) {
  return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
      width: 50,
      alignment: Alignment.center,
      child: Text(
        name,
        style: TextStyle(fontSize: 18),
      ));
}
