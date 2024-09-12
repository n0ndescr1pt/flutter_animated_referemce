import 'package:asdasdqweqweanimatin/tesla/controllers/home_controller.dart';
import 'package:asdasdqweqweanimatin/tesla/screens/component/bottom_navigation_bar.dart';
import 'package:asdasdqweqweanimatin/tesla/screens/component/lock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeslaScreen extends StatelessWidget {
  const TeslaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final teslaController = TeslaController();
    return AnimatedBuilder(
        animation: teslaController,
        builder: (context, snapshot) {
          return Scaffold(
            bottomNavigationBar: BottomNavBar(
              selectedTab: 0,
              onTap: (int value) {},
            ),
            body: SafeArea(child: LayoutBuilder(builder: (context, constrains) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: constrains.maxHeight * 0.1),
                    child: SvgPicture.asset(
                      "lib/tesla/assets/icons/Car.svg",
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                      right: constrains.maxWidth * 0.05,
                      child: Lock(
                        press: teslaController.updateRightLock,
                        isLock: teslaController.isRightDoorLock,
                      )),
                  Positioned(
                      bottom: constrains.maxWidth * 0.05,
                      child: Lock(
                        press: teslaController.updateBottomLock,
                        isLock: teslaController.isBottomDoorLock,
                      )),
                  Positioned(
                      top: constrains.maxWidth * 0.05,
                      child: Lock(
                        press: teslaController.updateTopLock,
                        isLock: teslaController.isTopDoorLock,
                      )),
                  Positioned(
                      left: constrains.maxWidth * 0.05,
                      child: Lock(
                        press: teslaController.updateLeftLock,
                        isLock: teslaController.isLeftDoorLock,
                      )),
                ],
              );
            })),
          );
        });
  }
}
