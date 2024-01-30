import 'package:flutter/material.dart';

class WidgetOfTabs extends StatelessWidget {
  const WidgetOfTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: [
        DayTab(),
        WeekTab(),
        MonthTab(),
      ]
      );
  }
}

class DayTab extends StatelessWidget {
  const DayTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Tab(
      icon: Tab(icon: Icon(IconData(0x44)))
    );
  }
}

class MonthTab extends StatelessWidget {
  const MonthTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Tab(
      icon: Tab(icon: Icon(IconData(0x4d)))
    );
  }
}

class WeekTab extends StatelessWidget {
  const WeekTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Tab(
      icon: Tab(icon: Icon(IconData(0x57)))
    );
  }
}
