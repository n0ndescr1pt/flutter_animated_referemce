import 'package:asdasdqweqweanimatin/tesla/constanins.dart';
import 'package:asdasdqweqweanimatin/tesla/controllers/home_controller.dart';
import 'package:asdasdqweqweanimatin/tesla/models/TyrePsi.dart';
import 'package:asdasdqweqweanimatin/tesla/screens/component/battery_status.dart';
import 'package:asdasdqweqweanimatin/tesla/screens/component/bottom_navigation_bar.dart';
import 'package:asdasdqweqweanimatin/tesla/screens/component/lock.dart';
import 'package:asdasdqweqweanimatin/tesla/screens/component/temp_detail.dart';
import 'package:asdasdqweqweanimatin/tesla/screens/component/tyre_psi.dart';
import 'package:asdasdqweqweanimatin/tesla/screens/component/tyres.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeslaScreen extends StatefulWidget {
  const TeslaScreen({Key? key}) : super(key: key);

  @override
  State<TeslaScreen> createState() => _TeslaScreenState();
}

class _TeslaScreenState extends State<TeslaScreen>
    with TickerProviderStateMixin {
  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  late AnimationController _tempAnimationController;
  late Animation<double> _animationCarShist;
  late Animation<double> _animationTempDetails;
  late Animation<double> _animationCarGlow;

  late AnimationController _tyreAnimationController;
  // We want to animate each tyre one by one
  late Animation<double> _animationTyre1Psi;
  late Animation<double> _animationTyre2Psi;
  late Animation<double> _animationTyre3Psi;
  late Animation<double> _animationTyre4Psi;

  late List<Animation<double>> _tyreAnimations;

  final TeslaController teslaController = TeslaController();

  void setupBatteryControllers() {
    _batteryAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: Interval(0.0, 0.5),
    );
    _animationBatteryStatus = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: Interval(0.6, 1),
    );
  }

  void setupTempControllers() {
    _tempAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _animationCarShist = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0.0, 0.2),
    );
    _animationTempDetails = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0.2, 0.4),
    );
    _animationCarGlow = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0.4, 0.6),
    );
  }

  void setupTyreAnimation() {
    _tyreAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _animationTyre1Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.34, 0.5));
    _animationTyre2Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.5, 0.66));
    _animationTyre3Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.66, 0.82));
    _animationTyre4Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.82, 1));
    _tyreAnimations = [
      _animationTyre1Psi,
      _animationTyre2Psi,
      _animationTyre3Psi,
      _animationTyre4Psi,
    ];
  }

  @override
  void initState() {
    setupTyreAnimation();
    setupBatteryControllers();
    setupTempControllers();
    super.initState();
  }

  @override
  void dispose() {
    _tyreAnimationController.dispose();
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([
          teslaController,
          _batteryAnimationController,
          _tempAnimationController,
          _tyreAnimationController
        ]),
        builder: (context, snapshot) {
          return Scaffold(
            bottomNavigationBar: BottomNavBar(
              selectedTab: teslaController.selectedTab,
              onTap: (index) {
                if (index == 1)
                  _batteryAnimationController.forward();
                else if (teslaController.selectedTab == 1 && index != 1)
                  _batteryAnimationController.reverse(from: 0.7);
                if (index == 2)
                  _tempAnimationController.forward();
                else if (teslaController.selectedTab == 2 && index != 2)
                  _tempAnimationController.reverse(from: 0.2);

                if (index == 3)
                  _tyreAnimationController.forward();
                else if (teslaController.selectedTab == 3 && index != 3)
                  _tyreAnimationController.reverse();

                teslaController.showTyreController(index);
                teslaController.tyreStatusController(index);
                teslaController.changeCurrentTab(index);
              },
            ),
            body: SafeArea(child: LayoutBuilder(builder: (context, constrains) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: constrains.maxHeight,
                    width: constrains.maxWidth,
                  ),
                  Positioned(
                    left: constrains.maxWidth / 2 * _animationCarShist.value,
                    height: constrains.maxHeight,
                    width: constrains.maxWidth,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: constrains.maxHeight * 0.1),
                      child: SvgPicture.asset(
                        "lib/tesla/assets/icons/Car.svg",
                        width: double.infinity,
                      ),
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
                  Opacity(
                    opacity: _animationBattery.value,
                    child: SvgPicture.asset(
                      "lib/tesla/assets/icons/Battery.svg",
                      width: constrains.maxWidth * 0.45,
                    ),
                  ),
                  Positioned(
                    top: 20 - (_animationBatteryStatus.value * 20),
                    height: constrains.maxHeight,
                    width: constrains.maxWidth,
                    child: Opacity(
                      opacity: _animationBatteryStatus.value,
                      child: BatteryStatus(constrains: constrains),
                    ),
                  ),
                  Positioned(
                      top: 60 - (_animationTempDetails.value * 60),
                      width: constrains.maxWidth,
                      height: constrains.maxHeight,
                      child: Opacity(
                          opacity: _animationTempDetails.value,
                          child: TempDetails(controller: teslaController))),
                  Positioned(
                    right: -180 * (1 - _animationCarGlow.value),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 150),
                      child: teslaController.isCoolSelected
                          ? Image.asset(
                              "lib/tesla/assets/images/Cool_glow_2.png",
                              key: UniqueKey(),
                              width: 200,
                            )
                          : Image.asset(
                              "lib/tesla/assets/images/Hot_glow_4.png",
                              key: UniqueKey(),
                              width: 200,
                            ),
                    ),
                  ),
                  if (teslaController.isShowTyre) ...tyres(constrains),
                  GridView.builder(
                      itemCount: 4,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: defaultPadding,
                          crossAxisSpacing: defaultPadding,
                          childAspectRatio:
                              constrains.maxWidth / constrains.maxHeight),
                      itemBuilder: (context, index) => ScaleTransition(
                            scale: _tyreAnimations[index],
                            child: TyrePsiCard(
                              isBottomTwoTyre: index > 1,
                              tyrePsi: demoPsiList[index],
                            ),
                          ))
                ],
              );
            })),
          );
        });
  }
}
