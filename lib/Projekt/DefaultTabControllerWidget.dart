import 'package:flutter_application_1/Projekt/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'WIdgetOfTabs.dart';


class MenuTabs extends StatelessWidget {
   const MenuTabs({
    super.key,
    required this.firstTabBarView,
    required this.secondTabBarView,
    required this.thirdTabBarView,
    });

   final Widget firstTabBarView;
   final Widget secondTabBarView;
   final Widget thirdTabBarView;
   

  @override
  Widget build(BuildContext context) {
    return  DefaultTabControllerWidget(
      firstTabBarView: firstTabBarView,
      secondTabBarView: secondTabBarView,
      thirdTabBarView:thirdTabBarView
);

  }
}

class DefaultTabControllerWidget extends StatelessWidget  {
   const DefaultTabControllerWidget({
    super.key,
    required this.firstTabBarView,
    required this.secondTabBarView,
    required this .thirdTabBarView,
  });

  final Widget firstTabBarView;
  final Widget secondTabBarView;
  final Widget thirdTabBarView;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80.0),
            child: AppBar(
              title: const Center(child: Text('Plan Zajęć')),
              bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: Expanded(child: WidgetOfTabs())),
            ),
          ),
          body: Stack(
            children: [
              TabBarView(children: [
                 firstTabBarView,
                 secondTabBarView,
                 thirdTabBarView,
              ]),
            ],
          ),
          drawer: const DrawerWidget(),
        ));
  }
}
