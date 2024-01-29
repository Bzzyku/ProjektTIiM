
  class Event {
  final String title;

  Event({required this.title});
}

class EventData {
  final DateTime date;
  final Event event;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  
  EventData({
    required this.date,
    required this.event,
    required this.description,
    required this.startTime,
    required this.endTime,
  });

  

  factory EventData.fromJson(Map<String, dynamic> json) {
    // Konwersja daty w formacie "YYYY_MM_DD" na obiekt DateTime
    DateTime date = DateTime.parse(json['date'].replaceAll('_', '-'));

    // Tworzenie obiektu Event
    Event event = Event(
      title: json['full'],
    );

    // Obliczanie startTime i endTime
    DateTime startTime = date.add(Duration(hours: 18, minutes: 30));
    DateTime endTime = startTime.add(Duration(hours: 1, minutes: 30));

    // Utworzenie pola description na podstawie innych pól
    String description = "NrZajec: ${json['nr_zajec']}, Full: ${json['full']}, NrBloku: ${json['nr_bloku']}, place: ${json['place']}";

    return EventData(
      date: date,
      event: event,
      description: description,
      startTime: startTime,
      endTime: endTime,
    );
  }
}


  




