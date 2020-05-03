import 'package:flutter/material.dart';

import 'package:conversor_de_moedas/Pages/Home.dart';

void main() async {
  runApp(MaterialApp(
      theme: ThemeData(
          cursorColor: Colors.lightGreen,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreen)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightGreen[800])),
            hintStyle: TextStyle(color: Colors.lightGreen),
          )),
      home: Home()));
}
