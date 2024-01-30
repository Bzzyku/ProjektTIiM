import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter_application_1/Projekt/CalendarEventDataAdapter.dart';
import 'package:flutter_application_1/Projekt/DefaultTabControllerWidget.dart';
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
    await getGroupsAndLecturers.fetchDataTimetable(widget.group);

    return CalendarEventDataAdapter.convertToCalendarEventDataList(getGroupsAndLecturers.events);
    
  }

//   @override
//   Widget build(BuildContext context) {
//     return  FutureBuilder<List<CalendarEventData<Event>>>(
//         future: fetchData(),
//         builder: (context, AsyncSnapshot<List<CalendarEventData<Event>>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator(); // Add a loading indicator
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             // Wrap the Scaffold with CalendarControllerProvider
//             return Material(
//               child: CalendarControllerProvider<Event>(
//                   controller: _eventController..addAll(snapshot.data!),
//                   child:  MaterialApp(
//         home: Scaffold(body:MenuTabs(
//           firstTabBarView: DayView(
//             controller: _eventController,
//             eventTileBuilder: (date, events, boundary, startDuration, endDuration) => Container(),
//             showVerticalLine: true,
//           ), 
//           secondTabBarView: WeekView(
//             controller: _eventController,
//           ), 
//           thirdTabBarView: MonthView(
//             controller: _eventController,
//           )),
//           drawer: const Drawer(),),
//     ),
// ),
//                   );
  

//           }
//         },
//   );}
// }


@override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
    controller: _eventController..addAll(calendarEventDataList),
    
    child:  MaterialApp(
        home: Scaffold(body:MenuTabs(
          firstTabBarView: DayView(
            controller: _eventController,
            eventTileBuilder: (date, events, boundary, startDuration, endDuration) => Container(),
            showVerticalLine: true,
          ), 
          secondTabBarView: WeekView(
            controller: _eventController,
          ), 
          thirdTabBarView: MonthView(
            controller: _eventController,
          )),
          drawer: const Drawer(),),
    ),
);
  }
}



// DateTime get _now => DateTime.now();
// List<CalendarEventData<Event>> _events = [
//   CalendarEventData(
//     date: _now,
//     event: Event(title: "Joe's Birthday"),
//     title: "Project meeting",
//     description: "Today is project meeting.",
//     startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
//     endTime: DateTime(_now.year, _now.month, _now.day, 22),
//   ),
//   CalendarEventData(
//     date: _now.add(Duration(days: 1)),
//     startTime: DateTime(_now.year, _now.month, _now.day, 18),
//     endTime: DateTime(_now.year, _now.month, _now.day, 19),
//     event: Event(title: "Wedding anniversary"),
//     title: "Wedding anniversary",
//     description: "Attend uncle's wedding anniversary.",
//   ),
//   CalendarEventData(
//     date: _now,
//     startTime: DateTime(_now.year, _now.month, _now.day, 14),
//     endTime: DateTime(_now.year, _now.month, _now.day, 17),
//     event: Event(title: "Football Tournament"),
//     title: "Football Tournament",
//     description: "Go to football tournament.",
//   ),
//   CalendarEventData(
//     date: _now.add(Duration(days: 3)),
//     startTime: DateTime(_now.add(Duration(days: 3)).year,
//         _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 10),
//     endTime: DateTime(_now.add(Duration(days: 3)).year,
//         _now.add(Duration(days: 3)).month, _now.add(Duration(days: 3)).day, 14),
//     event: Event(title: "Sprint Meeting."),
//     title: "Sprint Meeting.",
//     description: "Last day of project submission for last year.",
//   ),
//   CalendarEventData(
//     date: _now.subtract(Duration(days: 2)),
//     startTime: DateTime(
//         _now.subtract(Duration(days: 2)).year,
//         _now.subtract(Duration(days: 2)).month,
//         _now.subtract(Duration(days: 2)).day,
//         14),
//     endTime: DateTime(
//         _now.subtract(Duration(days: 2)).year,
//         _now.subtract(Duration(days: 2)).month,
//         _now.subtract(Duration(days: 2)).day,
//         16),
//     event: Event(title: "Team Meeting"),
//     title: "Team Meeting",
//     description: "Team Meeting",
//   ),
//   CalendarEventData(
//     date: _now.subtract(Duration(days: 2)),
//     startTime: DateTime(
//         _now.subtract(Duration(days: 2)).year,
//         _now.subtract(Duration(days: 2)).month,
//         _now.subtract(Duration(days: 2)).day,
//         10),
//     endTime: DateTime(
//         _now.subtract(Duration(days: 2)).year,
//         _now.subtract(Duration(days: 2)).month,
//         _now.subtract(Duration(days: 2)).day,
//         12),
//     event: Event(title: "Chemistry Viva"),
//     title: "Chemistry Viva",
//     description: "Today is Joe's birthday.",
//   ),
// ];