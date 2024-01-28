import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_application_1/Projekt/getGroupsAndLecturers.dart';

class DayViewTimetable extends StatefulWidget {
  const DayViewTimetable({super.key});

  @override
  State<DayViewTimetable> createState() => _DayViewTimetableState();
}

class _DayViewTimetableState extends State<DayViewTimetable> {
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
    controller: EventController(),
    child: const MaterialApp(
        home: Scaffold(
    body: DayView(),
),
    ),
);
  }
}