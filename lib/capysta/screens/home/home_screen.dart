import 'package:asdasdqweqweanimatin/capysta/constants.dart';
import 'package:asdasdqweqweanimatin/capysta/controllers/home_contoller.dart';
import 'package:asdasdqweqweanimatin/capysta/models/Product.dart';
import 'package:asdasdqweqweanimatin/capysta/screens/deatils/details_screen.dart';
import 'package:asdasdqweqweanimatin/capysta/screens/home/components/card_detail_view.dart';
import 'package:asdasdqweqweanimatin/capysta/screens/home/components/card_short_view.dart';
import 'package:flutter/material.dart';

import 'components/header.dart';
import 'components/product_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController = HomeController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Container(
          color: Color(0xFFEAEAEA),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return AnimatedBuilder(
                animation: homeController,
                builder: (BuildContext context, Widget? child) {
                  return Stack(
                    children: [
                      AnimatedPositioned(
                          duration: Duration(milliseconds: 200),
                          top: homeController.homeState == HomeState.home
                              ? 0
                              : -headerHeight,
                          right: 0,
                          left: 0,
                          height: headerHeight,
                          child: HomeHeader()),
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 200),
                        top: homeController.homeState == HomeState.home
                            ? headerHeight
                            : -(constraints.maxHeight -
                                cartBarHeight * 2 -
                                headerHeight),
                        left: 0,
                        right: 0,
                        height: (constraints.maxHeight - headerHeight) -
                            cartBarHeight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(defaultPadding * 1.5),
                              bottomRight:
                                  Radius.circular(defaultPadding * 1.5),
                            ),
                          ),
                          child: GridView.builder(
                            itemCount: demo_products.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              mainAxisSpacing: defaultPadding,
                              crossAxisSpacing: defaultPadding,
                            ),
                            itemBuilder: (context, index) => ProductCard(
                              product: demo_products[index],
                              press: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 300),
                                    reverseTransitionDuration:
                                        Duration(milliseconds: 300),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        FadeTransition(
                                      opacity: animation,
                                      child: DetailsScreen(
                                        controller: homeController,
                                        product: demo_products[index],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: homeController.homeState == HomeState.home
                            ? cartBarHeight
                            : (constraints.maxHeight - cartBarHeight),
                        duration: Duration(milliseconds: 200),
                        child: GestureDetector(
                          onVerticalDragUpdate: (details) {
                            if (details.primaryDelta! < 0) {
                              homeController.changeState(HomeState.cart);
                            } else {
                              homeController.changeState(HomeState.home);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(defaultPadding),
                            alignment: Alignment.topLeft,
                            color: Color(0xFFEAEAEA),
                            child: AnimatedSwitcher(
                                duration: panelTransition,
                                child: homeController.homeState ==
                                        HomeState.home
                                    ? CardShortView(controller: homeController)
                                    : CartDetailsView(
                                        controller: homeController)),
                          ),
                        ),
                      )
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
