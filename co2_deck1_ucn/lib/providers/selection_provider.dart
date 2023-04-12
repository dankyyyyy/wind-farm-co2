import 'package:flutter/material.dart';

class SelectionProvider extends ChangeNotifier {
  int _selectedTile = 0;

  int get selectedTile => _selectedTile;

  set selectedTile(int index) {
    _selectedTile = index;
    notifyListeners();
  }
}
