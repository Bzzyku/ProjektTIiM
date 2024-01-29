import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_application_1/Projekt/CalendarEventDataAdapter.dart';
import 'package:flutter_application_1/Projekt/DrawerWidget.dart';
import 'package:flutter_application_1/Projekt/getGroupsAndLecturers.dart';

class DayViewTimetable extends StatefulWidget {
  const DayViewTimetable({
    Key? key,
    required this.index,
    required this.group,
  }) : super(key: key);

  final int index;
  final String group;

  @override
  State<DayViewTimetable> createState() => _DayViewTimetableState();
}

class _DayViewTimetableState extends State<DayViewTimetable> {
  late List<CalendarEventData<Event>> calendarEventDataList;
  late EventController<Event> _eventController;

  @override
  void initState() {
    super.initState();
    calendarEventDataList = [];
    _eventController = EventController<Event>();
  }

  Future<List<CalendarEventData<Event>>> fetchData() async {
    GetGroupsAndLecturers getGroupsAndLecturers = GetGroupsAndLecturers();
    await getGroupsAndLecturers.fetchDataTimetable(widget.group);

    calendarEventDataList = CalendarEventDataAdapter.convertToCalendarEventDataList(getGroupsAndLecturers.events);
    return calendarEventDataList;
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<List<CalendarEventData<Event>>>(
        future: fetchData(),
        builder: (context, AsyncSnapshot<List<CalendarEventData<Event>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Add a loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Wrap the Scaffold with CalendarControllerProvider
            return Material(
              child: CalendarControllerProvider<Event>(
                controller: _eventController..addAll(snapshot.data!),
                child: Scaffold(
                  appBar: AppBar(
                    title: const Center(child: Text('Plan Zajeć')),
                  ),
                  body:  CalendarControllerProvider<Event>(
                controller: _eventController ,
                child: const DayView(),),
                  drawer: DrawerWidget(selectedIndex: widget.index),
                ),
                ),
            );
          }
        },
      );
  }
}