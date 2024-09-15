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

  bool isCoolSelected = true;

  void updateCoolSelectedTab() {
    isCoolSelected = !isCoolSelected;
    notifyListeners();
  }

  bool isShowTyre = false;

  void showTyreController(int index) {
    if (selectedTab != 3 && index == 3) {
      Future.delayed(
        Duration(milliseconds: 400),
        () {
          isShowTyre = true;
          notifyListeners();
        },
      );
    } else {
      isShowTyre = false;
      notifyListeners();
    }
  }

  bool isShowTyreStatus = false;

  void tyreStatusController(int index) {
    if (selectedTab != 3 && index == 3) {
      isShowTyreStatus = true;
      notifyListeners();
    } else {
      Future.delayed(Duration(milliseconds: 400), () {
        isShowTyreStatus = false;
        notifyListeners();
      });
    }
  }
}
