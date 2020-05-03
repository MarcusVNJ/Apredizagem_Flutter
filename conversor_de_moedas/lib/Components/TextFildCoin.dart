import 'package:flutter/material.dart';

class TextFildCoin extends StatefulWidget {
  TextFildCoin({this.coin, this.coinPrefix, this.controller, this.function});

  
  @required String coin, coinPrefix;
  @required TextEditingController controller;
  @required Function function;

  @override
  _TextFildCoinState createState() => _TextFildCoinState();
}

class _TextFildCoinState extends State<TextFildCoin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: TextField(
        controller: f.controller,
        decoration: InputDecoration(
            labelText: widget.coin,
            labelStyle: TextStyle(color: Colors.lightGreen[600]),
            border: OutlineInputBorder(),
            prefixText: widget.coinPrefix + ' '),
        style: TextStyle(color: Colors.lightGreen),
        keyboardType: TextInputType.number,
        onChanged: widget.function,
      ),
    );
  }
}
