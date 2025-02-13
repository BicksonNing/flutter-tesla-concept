import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tesla_animated_app/constants.dart';
import 'package:tesla_animated_app/home_controller.dart';
import 'package:tesla_animated_app/models/TyrePsi.dart';
import 'package:tesla_animated_app/widgets/battery_status.dart';
import 'package:tesla_animated_app/widgets/door_lock.dart';
import 'package:tesla_animated_app/widgets/temp_details.dart';
import 'package:tesla_animated_app/widgets/tesla_bottom_nav.dart';
import 'package:tesla_animated_app/widgets/tyre_psi_card.dart';
import 'package:tesla_animated_app/widgets/tyres.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;
  late AnimationController _tempAnimationController;
  late Animation<double> _animationCarShift;
  late Animation<double> _animationTempShowInfo;
  late Animation<double> _animationCoolGlow;
  late AnimationController _tyreAnimationController;
  late Animation<double> _animationTyre1Psi;
  late Animation<double> _animationTyre2Psi;
  late Animation<double> _animationTyre3Psi;
  late Animation<double> _animationTyre4Psi;

  late List<Animation<double>> _tyreAnimations;

  void setupTempAnimation() {
    _tempAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0.2, 0.4),
    );

    _animationTempShowInfo = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0.45, 0.65),
    );

    _animationCoolGlow = CurvedAnimation(
      parent: _tempAnimationController,
      curve: Interval(0.7, 1),
    );
  }

  void setupBatteryAnimation() {
    _batteryAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: Interval(0.0, 0.5),
    );

    _animationBatteryStatus = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: Interval(0.6, 1),
    );
  }

  void setupTyreAnimation() {
    _tyreAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1600),
    );

    _animationTyre1Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: Interval(0.34, 0.5),
    );

    _animationTyre2Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: Interval(0.5, 0.66),
    );

    _animationTyre3Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: Interval(0.66, 0.82),
    );

    _animationTyre4Psi = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: Interval(0.82, 1),
    );
  }

  @override
  void initState() {
    setupBatteryAnimation();
    setupTempAnimation();
    setupTyreAnimation();
    _tyreAnimations = [
      _animationTyre1Psi,
      _animationTyre2Psi,
      _animationTyre3Psi,
      _animationTyre4Psi
    ];
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    _tyreAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(
        [
          _controller,
          _batteryAnimationController,
          _tempAnimationController,
          _tyreAnimationController,
        ],
      ),
      builder: (context, _) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNav(
            onTap: (index) {
              if (index == 1)
                _batteryAnimationController.forward();
              else if (_controller.selectedBottomTab == 1 && index != 1)
                _batteryAnimationController.reverse();

              if (index == 2)
                _tempAnimationController.forward();
              else if (_controller.selectedBottomTab == 2 && index != 2)
                // This is what we want
                _tempAnimationController.reverse(from: 0.4);

              if (index == 3)
                _tyreAnimationController.forward();
              else if (_controller.selectedBottomTab == 3 && index != 3)
                _tyreAnimationController.reverse();

              _controller.showTyreController(index);
              _controller.tyreStausController(index);
              _controller.onBottomNavTabChange(index);
            },
            selectedTab: _controller.selectedBottomTab,
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constrains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                    ),
                    Positioned(
                      left: constrains.maxWidth / 2 * _animationCarShift.value,
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: constrains.maxHeight * 0.1),
                        child: SvgPicture.asset(
                          'assets/icons/Car.svg',
                          width: double.infinity,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      right: _controller.selectedBottomTab == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isRightDoorLock,
                          press: _controller.updateRightDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: _controller.selectedBottomTab == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isLeftDoorLock,
                          press: _controller.updateLeftDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      top: _controller.selectedBottomTab == 0
                          ? constrains.maxHeight * 0.13
                          : constrains.maxHeight / 1.8,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isBonnetLock,
                          press: _controller.updateBonnetLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: _controller.selectedBottomTab == 0
                          ? constrains.maxHeight * 0.13
                          : constrains.maxHeight / 1.8,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isTrunkLock,
                          press: _controller.updateTrunkLock,
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: _animationBattery.value,
                      child: SvgPicture.asset(
                        'assets/icons/Battery.svg',
                        width: constrains.maxWidth * 0.45,
                      ),
                    ),
                    Positioned(
                      top: 50 * (1 - _animationBatteryStatus.value),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Opacity(
                        opacity: _animationBatteryStatus.value,
                        child: BatteryStatus(
                          constrains: constrains,
                        ),
                      ),
                    ),
                    //Temp
                    Positioned(
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      top: 60 * (1 - _animationTempShowInfo.value),
                      child: Opacity(
                          opacity: _animationTempShowInfo.value,
                          child: TempDetails(controller: _controller)),
                    ),
                    Positioned(
                      right: -180 * (1 - _animationCoolGlow.value),
                      child: Opacity(
                        opacity: _animationCoolGlow.value,
                        child: AnimatedSwitcher(
                          duration: defaultDuration * 3,
                          child: _controller.isCoolSelected
                              ? Image.asset(
                                  'assets/images/Cool_glow_2.png',
                                  key: UniqueKey(),
                                  width: 200,
                                )
                              : Image.asset(
                                  'assets/images/Hot_glow_4.png',
                                  key: UniqueKey(),
                                  width: 200,
                                ),
                        ),
                      ),
                    ),

                    if (_controller.isShowTyre) ...tyres(constrains),
                    if (_controller.isShowTyreStatus)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: defaultPadding,
                                  mainAxisSpacing: defaultPadding,
                                  childAspectRatio: constrains.maxWidth /
                                      constrains.maxHeight),
                          itemBuilder: (context, index) => ScaleTransition(
                            scale: _tyreAnimations[index],
                            child: TyrePsiCard(
                              isBottomTwoTyre: index > 1,
                              tyrePsi: demoPsiList[index],
                            ),
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
