import 'dart:convert';

import 'package:atividades/Controller/Controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _toDoController = TextEditingController();
  Controller _controller = Controller();

  @override
  void initState() {
    super.initState();
    _controller.readData().then((data) {
      setState(() {
        _controller.toDoList = json.decode(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          //margin: EdgeInsets.only(left: 10, right: 10),
          padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
          decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.elliptical(300, 300)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.9),
                    offset: Offset(0, 5),
                    blurRadius: 7)
              ]),
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: TextField(
                          controller: _toDoController,
                          decoration: InputDecoration(
                            // contentPadding: EdgeInsets.all(10),
                            hintStyle: TextStyle(color: Colors.blue[50]),
                            hintText: "Nome da Tarefa",
                            border: InputBorder.none,
                          )))),
              Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: IconButton(
                      iconSize: 40,
                      color: Colors.blueGrey[100],
                      icon: Icon(Icons.add),
                      onPressed: _update))
            ],
          ),
        ),
        Expanded(
            child: RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 15),
                    itemCount: _controller.toDoList.length,
                    itemBuilder: (context, index) {
                      return BannerListView(index);
                      //return BannerListView(rola: index);
                    })))
      ],
    );
  }

  void _update() {
    setState(() {
      _controller.addToDo(_toDoController);
    });
  }

  Widget BannerListView(int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
          decoration: BoxDecoration(
              color: Colors.red[300], borderRadius: BorderRadius.circular(7)),
          width: double.infinity,
          height: 80,
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
          child: Align(
              alignment: Alignment(-0.9, 0.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ))),
      direction: DismissDirection.startToEnd,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(7),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.blueGrey.withOpacity(0.5),
                    offset: Offset(5, 5),
                    blurRadius: 7)
              ]),
          width: double.infinity,
          height: 80,
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
          alignment: Alignment.center,
          child: CheckboxListTile(
              title: Text(_controller.toDoList[index]['title']),
              value: _controller.toDoList[index]['check'],
              secondary: CircleAvatar(
                child: Icon(_controller.toDoList[index]['check']
                    ? Icons.check
                    : Icons.error),
              ),
              onChanged: (check) {
                setState(() {
                  _controller.toDoList[index]["check"] = check;
                  _controller.saveData();
                });
              })),
      onDismissed: (diretional) {
        setState(() {
          _controller.lastRemovedPos = index;
          _controller.lastRemoved = Map.from(_controller.toDoList[index]);
          _controller.toDoList.removeAt(index);
          _controller.saveData();
          snackBar();
        });
      },
    );
  }

  void snackBar() {
    final snack = SnackBar(
        content: Text(
            'Tarefa \"${_controller.lastRemoved["title"]}\" foi removida!'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
            label: "Desfazer",
            onPressed: () {
              setState(() {
                _controller.toDoList.insert(
                    _controller.lastRemovedPos, _controller.lastRemoved);
                _controller.saveData();
              });
            }));

    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(snack);
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _controller.toDoList.sort((a, b) {
        if (a["check"] && !b["check"])
          return 1;
        else if (!a["check"] && b["check"])
          return -1;
        else
          return 0;
      });
      _controller.saveData();
    });
    return null;
  }
}
