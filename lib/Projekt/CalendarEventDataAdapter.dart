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
  DateTime eventDate = DateTime.parse(item['date'].replaceAll('_', '-')).add(Duration(hours:6+int.parse(item['nr_bloku']),minutes:10+50*int.parse(item['nr_bloku'])));
  
  // Ustawienie startTime na datę z pola 'date'
  DateTime startTime = eventDate;

  // Ustawienie endTime na 1 godzinę i 30 minut po startTime
  DateTime endTime = startTime.add(const Duration(hours: 1, minutes: 35));

  return CalendarEventData<Event>(
    date: eventDate,
    startTime: startTime,
    endTime: endTime,
    title: "${item['short']??''} ${item['form']?? ''} ${item['place']}",  
    description: "${item['full']} ${item['short']} Sala: ${item['place']} Prowadzący: ${item['id_prow']} Zajęcia nr: ${item['nr_zajec']} Blok:${item['nr_bloku']} typ: ${item['form']}",  
    color: setColor(item),
    event: Event(title: item['full'] ?? ""),  
    endDate: endTime,
    titleStyle: const TextStyle(color: Colors.black),
    descriptionStyle: const  TextStyle(color: Colors.black87),
  );
}).toList();
  }

}
Color setColor(dynamic item){
if("${item['form']}" == "(ć)")
    {
     return const Color(0xFFdefcf9);
    }
    else if("${item['form']}" == "(w)")
    {
       return const Color(0xFFcadefc);
    }
    else if("${item['form']}" == "(P)")
    {
       return const Color(0xFFc3bef0);
    }
    else
    {
       return const Color(0xFFcca8e9);
    } 
}