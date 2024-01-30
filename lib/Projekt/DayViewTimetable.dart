import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_application_1/Projekt/CalendarEventDataAdapter.dart';
import 'package:flutter_application_1/Projekt/DefaultTabControllerWidget.dart';
import 'package:flutter_application_1/Projekt/DrawerWidget.dart';
import 'package:flutter_application_1/Projekt/getGroupsAndLecturers.dart';

import 'Message.dart';

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
  late EventController<Event> _eventController;
  List<CalendarEventData<Event>> calendarEventDataList = [];
  @override
  void initState() {
    super.initState();
    fetchData().then((value) => {
      setState(() {
      calendarEventDataList=value;
          }),
      });
    _eventController = EventController<Event>();

      

  }

  Future<List<CalendarEventData<Event>>> fetchData() async {
    GetGroupsAndLecturers getGroupsAndLecturers = GetGroupsAndLecturers();
    if(widget.index == 0){
    await getGroupsAndLecturers.fetchDataTimetable(widget.group);
    return CalendarEventDataAdapter.convertToCalendarEventDataList(getGroupsAndLecturers.events);
    }
    else{
      await getGroupsAndLecturers.fetchDataLecturerTimetable(widget.group);
    return CalendarEventDataAdapter.convertToCalendarEventDataList(getGroupsAndLecturers.events);
    }
  }

@override
  Widget build(BuildContext context) {
    var now = DateTime.now();

    return CalendarControllerProvider(
    controller: _eventController..addAll(calendarEventDataList),
    
    child:  MaterialApp(
        home: Scaffold(body:MenuTabs(
          firstTabBarView: DayView(
            controller: _eventController,
            heightPerMinute: 1,
            startDuration: const Duration(hours: 7),
            showVerticalLine: true,
            onEventTap: (events, date) => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Message(events: events[0],);
                },
              ),
          ), 
          secondTabBarView: WeekView(
            controller: _eventController,
            heightPerMinute: 1,
            onEventTap: (events, date) => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Message(events: events[0],);
                },
              ),
          ), 
          thirdTabBarView: MonthView(
            controller: _eventController,
            onEventTap: (events, date) => showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Message(events: events,);
                },
              ),
          )),
          drawer: const Drawer(),),
    ),
);
  }
}





