import 'package:flutter/material.dart';
import 'package:flutter_application_1/Projekt/Api_manager.dart';
import 'package:calendar_view/calendar_view.dart'; 
class Event {
  final String title;
  final String description;

  Event({
    required this.title,
    required this.description,
  });
}

  class GetGroupsAndLecturers{
    GetGroupsAndLecturers();

  List<String> groups = [];
  Map<String,String> lecturers ={};
  List<DropdownMenuItem<String>> savedLecturers = [];
  List<DropdownMenuItem<String>> savedGroup = [];
  Timetable api = const Timetable();
  Map<String,Map<String, List<String>>> events = {};
  List<CalendarEventData<Event>> savedEvents = [];


  Future<void> fetchDataTimetable(String group) async {
    try {
      Map<String, Map<String, List<String>>> apiData = await api.groupTimetable(group); 
        events = apiData;
    } catch (e) {
      print("Error");
    }
  }

  Future<void> fetchDataGroup() async {
    try {
      List<String> apiData = await api.group(); 
        groups = apiData;
    } catch (e) {
      print("Error");
    }
  }

  Future<void> fetchDataGroupLecturers() async {
    try {
      Map<String, String> apiData = await api.lecturers();
        lecturers = apiData;
    } catch (e) {
      print("Error");
    }
  }

  List<DropdownMenuItem<String>> convertListOfStringsToDropdownMenuItems(List<String> groups) {
  return  groups.map((group) {
    return DropdownMenuItem<String>(
      value: group,
      child: Text(group,
                  style: const TextStyle(
                  fontSize: 14,)
                  ),
    );
  }).toList(); 
}

  List<DropdownMenuItem<String>> convertMapOfStringsToDropdownMenuItems(Map<String,String> lecturers) {
  return  lecturers.values.map((lecturer) {
    return DropdownMenuItem<String>(
      value: lecturer,
      child: Text(lecturer,
                  style: const TextStyle(
                  fontSize: 14,)
                  ),
    );
  }).toList(); 
}

List<CalendarEventData<Event>> convertGroupTimetableToListOfEvents(Map<String, Map<String, List<String>>> data) {
  

  // Iteracja po dacie
  data.forEach((date, blocks) {
    // Iteracja po blokach
    blocks.forEach((block, subjects) {
      // Iteracja po przedmiotach
      subjects.forEach((subject) {
        // Ustawienie odpowiednich dat i godzin dla startTime i endTime
       DateTime startTime = DateTime.parse('$date ${block.split('-')[0]}');
        DateTime endTime = DateTime.parse('$date ${block.split('-')[1]}').add(const Duration(hours: 1, minutes: 35));

        // Przykład: Tworzenie instancji CalendarEventData i dodanie jej do listy
        savedEvents.add(
          CalendarEventData(
            date: startTime,
            startTime: startTime,
            endTime: endTime,
            event: Event(
              title: subject[0], // Display
              description: subject[1], // Pełne info
            ),
            title: subject[0], // Display
            description: subject[1], // Pełne info
          ),
        );
      });
    });
  });

  return savedEvents;
}

Future<void> fetchDataAndBuildEvents(String group) async {
      await fetchDataTimetable(group);
        savedEvents = convertGroupTimetableToListOfEvents(events);
         
  }

Future<void> fetchDataAndBuildItems(int value) async {
    if (value == 1 && savedGroup.isEmpty) {
      await fetchDataGroup();
      savedGroup = convertListOfStringsToDropdownMenuItems(groups);
      
    }
     else if (value == 0 && savedLecturers.isEmpty){
      await fetchDataGroupLecturers();
        savedLecturers = convertMapOfStringsToDropdownMenuItems(lecturers);   
    }
  }

 

  }