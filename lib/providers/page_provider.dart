import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {
  int selectedIndex = 0;
  int selecedPage = 0;
  void selecteIndex(int value){
    selectedIndex = value;
    notifyListeners();
  }

  void selectPage(int value){
selecedPage = value;
notifyListeners();
  }
}