import 'package:flutter/cupertino.dart';

class SelectedTile extends ChangeNotifier {
  int _selectedTile = 0;

  int get selectedTile => _selectedTile;

  set selectedTile(int index) {
    _selectedTile = index;
    notifyListeners();
  }
}
