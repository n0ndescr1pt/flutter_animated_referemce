import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTap;
  const BottomNavBar({Key? key, required this.selectedTab, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        items: List.generate(
            assetsNav.length,
            (index) => BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  assetsNav[index],
                  color: index == selectedTab
                      ? Colors.lightBlueAccent
                      : Colors.white54,
                ),
                label: '')));
  }
}

final assetsNav = [
  "lib/tesla/assets/icons/Lock.svg",
  "lib/tesla/assets/icons/Charge.svg",
  "lib/tesla/assets/icons/Temp.svg",
  "lib/tesla/assets/icons/Tyre.svg",
];
