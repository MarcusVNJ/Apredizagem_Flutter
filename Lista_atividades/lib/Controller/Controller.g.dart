// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Controller on _Controller, Store {
  final _$toDoListAtom = Atom(name: '_Controller.toDoList');

  @override
  List<dynamic> get toDoList {
    _$toDoListAtom.context.enforceReadPolicy(_$toDoListAtom);
    _$toDoListAtom.reportObserved();
    return super.toDoList;
  }

  @override
  set toDoList(List<dynamic> value) {
    _$toDoListAtom.context.conditionallyRunInAction(() {
      super.toDoList = value;
      _$toDoListAtom.reportChanged();
    }, _$toDoListAtom, name: '${_$toDoListAtom.name}_set');
  }

  final _$lastRemovedAtom = Atom(name: '_Controller.lastRemoved');

  @override
  Map<String, dynamic> get lastRemoved {
    _$lastRemovedAtom.context.enforceReadPolicy(_$lastRemovedAtom);
    _$lastRemovedAtom.reportObserved();
    return super.lastRemoved;
  }

  @override
  set lastRemoved(Map<String, dynamic> value) {
    _$lastRemovedAtom.context.conditionallyRunInAction(() {
      super.lastRemoved = value;
      _$lastRemovedAtom.reportChanged();
    }, _$lastRemovedAtom, name: '${_$lastRemovedAtom.name}_set');
  }

  final _$lastRemovedPosAtom = Atom(name: '_Controller.lastRemovedPos');

  @override
  int get lastRemovedPos {
    _$lastRemovedPosAtom.context.enforceReadPolicy(_$lastRemovedPosAtom);
    _$lastRemovedPosAtom.reportObserved();
    return super.lastRemovedPos;
  }

  @override
  set lastRemovedPos(int value) {
    _$lastRemovedPosAtom.context.conditionallyRunInAction(() {
      super.lastRemovedPos = value;
      _$lastRemovedPosAtom.reportChanged();
    }, _$lastRemovedPosAtom, name: '${_$lastRemovedPosAtom.name}_set');
  }

  final _$_ControllerActionController = ActionController(name: '_Controller');

  @override
  void addToDo(TextEditingController textFild) {
    final _$actionInfo = _$_ControllerActionController.startAction();
    try {
      return super.addToDo(textFild);
    } finally {
      _$_ControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'toDoList: ${toDoList.toString()},lastRemoved: ${lastRemoved.toString()},lastRemovedPos: ${lastRemovedPos.toString()}';
    return '{$string}';
  }
}
