import 'package:flutter/cupertino.dart';

class AppTabController with ChangeNotifier{

  int _currentIndex=0;
  int get  currentIndex =>_currentIndex;
  int _currentTab=0;
  int get  currentTab =>_currentTab;
  setIndex(index){
    _currentIndex=index;
    notifyListeners();
  }
  setTab(index){
    _currentTab=index;
    notifyListeners();
  }
}