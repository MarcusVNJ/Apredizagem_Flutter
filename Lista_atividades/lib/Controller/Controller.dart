import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'Controller.g.dart';

class Controller = _Controller with _$Controller;

abstract class _Controller with Store {
  @observable
  List toDoList = [];

  @observable
  Map<String, dynamic> lastRemoved;

  @observable
  int lastRemovedPos;

  @action
  void addToDo(TextEditingController textFild) {
    Map<String, dynamic> newToDo = Map();
    newToDo["title"] = textFild.text;
    newToDo["check"] = false;
    toDoList.add(newToDo);
    textFild.text = '';
    saveData();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    
  }

  Future<File> getFile() async {
    final directory = await getApplicationSupportDirectory();
    return File("${directory.path}/Dados.json");
  }

  Future<File> saveData() async {
    String data = json.encode(toDoList);
    final file = await getFile();
    return file.writeAsString(data);
  }

  Future<String> readData() async {
    try {
      final file = await getFile();
      return file.readAsString();
    } catch (e) {
      print(e.toString());
    }
  }
}
