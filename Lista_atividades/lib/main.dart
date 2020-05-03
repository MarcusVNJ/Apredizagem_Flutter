import 'package:atividades/View/HomePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueGrey[50],
          appBar: AppBar(
            backgroundColor: Colors.blue[800],
            elevation: 0.0,
          ),
          body: HomePage()),
    ));
