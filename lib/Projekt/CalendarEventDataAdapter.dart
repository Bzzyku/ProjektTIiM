import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
class Event {
  final String title;

  Event({required this.title});
}

class CalendarEventDataAdapter {
  static List<CalendarEventData<Event>> convertToCalendarEventDataList(List<dynamic> apiData) {
    return apiData.map((dynamic item) {
  // Parsowanie daty z pola 'date'
  DateTime eventDate = DateTime.parse(item['date'].replaceAll('_', '-'));
  
  // Ustawienie startTime na datę z pola 'date'
  DateTime startTime = eventDate;

  // Ustawienie endTime na 1 godzinę i 30 minut po startTime
  DateTime endTime = startTime.add(Duration(hours: 1, minutes: 35));

  return CalendarEventData<Event>(
    date: eventDate,
    startTime: startTime,
    endTime: endTime,
    title: item['full'] ?? "",  // Ustawienie tytułu z pola 'full'
    description: "${item['short']} ${item['place']} ${item['id_prow']} ${item['nr_zajec']} ${item['nr_bloku']}",  // Ustawienie opisu z kilku pól
    color: Colors.lightBlue,
    event: Event(title: item['full'] ?? ""),  // Ustawienie tytułu eventu z pola 'full'
    endDate: endTime,
    titleStyle: const TextStyle(color: Colors.black),
    descriptionStyle: const  TextStyle(color: Colors.grey),
  );
}).toList();
  }

}