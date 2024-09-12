import 'package:asdasdqweqweanimatin/tesla/constanins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Lock extends StatelessWidget {
  final VoidCallback press;
  final bool isLock;
  const Lock({Key? key, required this.press, required this.isLock})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: AnimatedSwitcher(
        switchInCurve: Curves.easeInOutBack,
        duration: defaultDuration,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: isLock
            ? SvgPicture.asset(
                "lib/tesla/assets/icons/door_lock.svg",
                key: ValueKey("lock"),
              )
            : SvgPicture.asset(
                "lib/tesla/assets/icons/door_unlock.svg",
                key: ValueKey("unlock"),
              ),
      ),
    );
  }
}
