import 'package:flutter/material.dart';
import 'Projekt/Api_manager.dart';



class ButtonSelectGroup extends StatefulWidget {
  @override
  _ButtonSelectGroup createState() => _ButtonSelectGroup();
}

class _ButtonSelectGroup extends State<ButtonSelectGroup> {
  Timetable api = const Timetable();
  bool isExpanded = false;
  List<String> options = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<String> apiData = await api.group(); // Wywołaj metodę pobierającą dane z API
      setState(() {
        options = apiData;
      });
    } catch (e) {
      print('Wystąpił błąd podczas pobierania danych: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
          color: Colors.white, // Kolor tła dla całej kolumny
          borderRadius: BorderRadius.circular(10.0), // Zaokrąglenie rogów
          border: Border.all(color: Colors.grey), // Obramowanie dla całej kolumny
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Wybierz grupę',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Icon(
                    isExpanded ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                    size: 30.0,
                  ),
                ],
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isExpanded ? 50.0 : 0.0,
            
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(options[index]),
                  onTap: () {

                  },
                );
              },
            ),
          ),
        ],
      );
}
}