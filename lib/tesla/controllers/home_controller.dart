import 'package:flutter/material.dart';

class TeslaController extends ChangeNotifier {
  int selectedTab = 0;

  void changeCurrentTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  bool isRightDoorLock = true;
  bool isLeftDoorLock = true;
  bool isTopDoorLock = true;
  bool isBottomDoorLock = true;

  void updateRightLock() {
    isRightDoorLock = !isRightDoorLock;
    notifyListeners();
  }

  void updateLeftLock() {
    isLeftDoorLock = !isLeftDoorLock;
    notifyListeners();
  }

  void updateTopLock() {
    isTopDoorLock = !isTopDoorLock;
    notifyListeners();
  }

  void updateBottomLock() {
    isBottomDoorLock = !isBottomDoorLock;
    notifyListeners();
  }
}
