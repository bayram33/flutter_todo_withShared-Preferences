import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item.dart';

class ItemData with ChangeNotifier {
  final List<Item> _items = [
    Item(title: "listen the music"),
    Item(title: "do exercise"),
    Item(title: "dont love again"),
  ];

  // ignore: body_might_complete_normally_nullable
  void Function(bool?)? toggleStatus(int index) {
    _items[index].toggleStatus();
    saveItemsToSharedPref(_items);
    notifyListeners();
  }

  // ignore: body_might_complete_normally_nullable
  void Function()? addItem(String title) {
    _items.add(Item(title: title));
    saveItemsToSharedPref(_items);
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    saveItemsToSharedPref(_items);
    notifyListeners();
  }

  List<Item> get items => _items;

  // SharedPref and Empty List
  static late SharedPreferences _sharedPref;
  final List<String> _itemAsString = [];

  // SharedPref Functions
  Future<void> createPrefObject() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  void saveItemsToSharedPref(List<Item> items) {
    // List<Item> --> List<String>
    _itemAsString.clear();
    for (var item in _items) {
      _itemAsString.add(json.encode(item.toMap()));
    }
    // sharedpref e kaydet
    _sharedPref.setStringList("toDoData", _itemAsString);
  }

  void loadItemsFromSharedPref() {
    List<String>? tempList = _sharedPref.getStringList("toDoData") ?? [];
    _items.clear();
    for (var item in tempList) {
      _items.add(Item.fromMap(json.decode(item)));
    }
  }
}
