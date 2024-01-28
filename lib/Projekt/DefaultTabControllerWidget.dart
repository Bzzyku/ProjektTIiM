import 'package:flutter_application_1/Projekt/DrawerWidget.dart';
import 'package:flutter/material.dart';
import 'WIdgetOfTabs.dart';


class MyApp extends StatelessWidget {
   const MyApp({
    super.key,
    required this.firstTabBarView,
    required this.secondTabBarView,
    required this.text,
    });

   final Widget firstTabBarView;
   final Widget secondTabBarView;
   final String text;

  @override
  Widget build(BuildContext context) {
    return  Material(
    
      child: DefaultTabControllerWidget(firstTabBarView: firstTabBarView,secondTabBarView: secondTabBarView,text: text,),
    );
  }
}

class DefaultTabControllerWidget extends StatelessWidget  {
   const DefaultTabControllerWidget({
    super.key,
    required this.firstTabBarView,
    required this.secondTabBarView,
    required this.text,
  });

  final Widget firstTabBarView;
  final Widget secondTabBarView;
  final String text;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
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
              ]),
            ],
          ),
          drawer: const DrawerWidget(),
        ));
  }
}
