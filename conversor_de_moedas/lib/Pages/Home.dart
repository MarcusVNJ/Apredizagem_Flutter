import 'package:conversor_de_moedas/Components/TextFildCoin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    'https://api.hgbrasil.com/finance?format=json-cors&key=d7a0d327';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dolar, euro, libra, peso;

  final _realController = TextEditingController();
  final _dolarController = TextEditingController();
  final _euroController = TextEditingController();
  final _libraController = TextEditingController();
  final _pesoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[900],
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (ctx, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Text('Carregando esta merda...',
                        textAlign: TextAlign.center));
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text('Que merda viu, vai da não...',
                          textAlign: TextAlign.center));
                } else {
                  _defineCoinValue(snapshot);
                  return SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.local_atm,
                        size: 150.0,
                        color: Colors.lightGreen[800],
                      ),
                      TextFildCoin(
                        coin: 'Real',
                        coinPrefix: 'R\$',
                        function: _realChanged,
                        controller: _realController,
                      ),
                      TextFildCoin(
                        coin: 'Dolar',
                        coinPrefix: 'US\$',
                        controller: _dolarController,
                        function: _dolarChanged,
                      ),
                      TextFildCoin(
                        coin: 'Euro',
                        coinPrefix: '€',
                        controller: _euroController,
                        function: _euroChanged,
                      ),
                      TextFildCoin(
                        coin: 'Libra Esterlina',
                        coinPrefix: '£',
                        controller: _libraController,
                        function: _libraChanged,
                      ),
                      TextFildCoin(
                        coin: 'Peso Argentino',
                        coinPrefix: '\$',
                        controller: _pesoController,
                        function: _pesoChanged,
                      ),
                    ],
                  ));
                }
            }
          }),
    );
  }

  Future<Map> getData() async {
    http.Response response = await http.get(request);
    return json.decode(response.body);
  }

  void _defineCoinValue(AsyncSnapshot snapshot) {
    this.dolar = snapshot.data['results']['currencies']['USD']['buy'];
    this.euro = snapshot.data['results']['currencies']['EUR']['buy'];
    this.libra = snapshot.data['results']['currencies']['GBP']['buy'];
    this.peso = snapshot.data['results']['currencies']['ARS']['buy'];
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    }
    double real = double.parse(text);
    _dolarController.text = (real / dolar).toStringAsFixed(2);
    _euroController.text = (real / euro).toStringAsFixed(2);
    _libraController.text = (real / libra).toStringAsFixed(2);
    _pesoController.text = (real / peso).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    }
    double dolar = double.parse(text);
    _realController.text = (dolar * this.dolar).toStringAsFixed(2);
    _euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
    _libraController.text = (dolar * this.dolar / libra).toStringAsFixed(2);
    _pesoController.text = (dolar * this.dolar / peso).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    }
    double euro = double.parse(text);
    _realController.text = (euro * this.euro).toStringAsFixed(2);
    _dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
    _libraController.text = (euro * this.euro / libra).toStringAsFixed(2);
    _pesoController.text = (euro * this.euro / peso).toStringAsFixed(2);
  }

  void _libraChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    }
    double libra = double.parse(text);
    _realController.text = (libra * this.libra).toStringAsFixed(2);
    _dolarController.text = (libra * this.libra / dolar).toStringAsFixed(2);
    _euroController.text = (libra * this.libra / euro).toStringAsFixed(2);
    _pesoController.text = (libra * this.libra / peso).toStringAsFixed(2);
  }

  void _pesoChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
    }
    double peso = double.parse(text);
    _realController.text = (peso * this.peso).toStringAsFixed(2);
    _dolarController.text = (peso * this.peso / dolar).toStringAsFixed(2);
    _euroController.text = (peso * this.peso / euro).toStringAsFixed(2);
    _libraController.text = (peso * this.peso / libra).toStringAsFixed(2);
  }

  void _clearAll() {
    _realController.text = '';
    _dolarController.text = '';
    _euroController.text = '';
    _libraController.text = '';
    _pesoController.text = '';
  }
}
