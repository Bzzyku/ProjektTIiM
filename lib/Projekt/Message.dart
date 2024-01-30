import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

import 'CalendarEventDataAdapter.dart';

class Message extends StatelessWidget {
   const Message({
    super.key,
    required this.events,
  });
  final CalendarEventData<Event> events;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Opis'),
      content: Text(events.description),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Zamknij'),
        ),
      ],
    );
  }
}