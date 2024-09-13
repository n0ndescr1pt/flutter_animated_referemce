import 'package:asdasdqweqweanimatin/tesla/constanins.dart';
import 'package:asdasdqweqweanimatin/tesla/controllers/home_controller.dart';
import 'package:asdasdqweqweanimatin/tesla/screens/component/bottom_navigation_bar.dart';
import 'package:asdasdqweqweanimatin/tesla/screens/component/lock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeslaScreen extends StatefulWidget {
  const TeslaScreen({Key? key}) : super(key: key);

  @override
  State<TeslaScreen> createState() => _TeslaScreenState();
}

class _TeslaScreenState extends State<TeslaScreen> {
  final TeslaController teslaController = TeslaController();
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: teslaController,
        builder: (context, snapshot) {
          return Scaffold(
            bottomNavigationBar: BottomNavBar(
              selectedTab: teslaController.selectedTab,
              onTap: teslaController.changeCurrentTab,
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
                  AnimatedPositioned(
                      duration: defaultDuration,
                      right: teslaController.selectedTab == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        opacity: teslaController.selectedTab == 0 ? 1 : 0,
                        duration: defaultDuration,
                        child: IgnorePointer(
                          ignoring: teslaController.selectedTab != 0,
                          child: Lock(
                            press: teslaController.updateRightLock,
                            isLock: teslaController.isRightDoorLock,
                          ),
                        ),
                      )),
                  AnimatedPositioned(
                      duration: defaultDuration,
                      left: teslaController.selectedTab == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        opacity: teslaController.selectedTab == 0 ? 1 : 0,
                        duration: defaultDuration,
                        child: IgnorePointer(
                          ignoring: teslaController.selectedTab != 0,
                          child: Lock(
                            press: teslaController.updateLeftLock,
                            isLock: teslaController.isLeftDoorLock,
                          ),
                        ),
                      )),
                  AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: teslaController.selectedTab == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        opacity: teslaController.selectedTab == 0 ? 1 : 0,
                        duration: defaultDuration,
                        child: IgnorePointer(
                          ignoring: teslaController.selectedTab != 0,
                          child: Lock(
                            press: teslaController.updateBottomLock,
                            isLock: teslaController.isBottomDoorLock,
                          ),
                        ),
                      )),
                  AnimatedPositioned(
                      duration: defaultDuration,
                      top: teslaController.selectedTab == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        opacity: teslaController.selectedTab == 0 ? 1 : 0,
                        duration: defaultDuration,
                        child: IgnorePointer(
                          ignoring: teslaController.selectedTab != 0,
                          child: Lock(
                            press: teslaController.updateTopLock,
                            isLock: teslaController.isTopDoorLock,
                          ),
                        ),
                      )),
                ],
              );
            })),
          );
        });
  }
}
