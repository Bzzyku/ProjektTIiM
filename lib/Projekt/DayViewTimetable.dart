import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_application_1/Projekt/DrawerWidget.dart';
import 'package:flutter_application_1/Projekt/getGroupsAndLecturers.dart';

class DayViewTimetable extends StatefulWidget {
  const DayViewTimetable({
    super.key, 
    required this.index, 
    required this.group,
    });
  final int index;
  @override
  State<DayViewTimetable> createState() => _DayViewTimetableState();
  final String group;
  
}

class _DayViewTimetableState extends State<DayViewTimetable> {
  GetGroupsAndLecturers getGroupsAndLecturers = GetGroupsAndLecturers();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CalendarEventData<Event>>>(
      future:getGroupsAndLecturers.fetchDataAndBuildEvents(widget.group) , 
      builder: (BuildContext context, AsyncSnapshot<List<CalendarEventData<Event>>> snapshot){
    return CalendarControllerProvider(
    controller: EventController(),
    child:  MaterialApp(
        home: Scaffold(
          appBar:  AppBar(
          title: const Center(child: Text('Plan Zajeć')),
        ),
    body: const DayView(),
     drawer:  DrawerWidget(selectedIndex: widget.index) ,

),
    ),
);
  }
    );
}
}