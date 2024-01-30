import 'package:flutter/material.dart';
import 'package:flutter_application_1/Projekt/DrawerWidget.dart';
import 'package:flutter_application_1/Projekt/SearchButton.dart';

void main() {
  runApp(
     const  MaterialApp(
        home: WelcomeScreen(),
        // your app configuration
      ),
    );
}

class WelcomeScreen extends StatelessWidget {
    const WelcomeScreen({
    super.key,
    this.index = 0,
    });
    final int index;

  String functionstring(value){
    if (value == 0)
    {
      return 'Wybierz grupę aby wysiwetlić jej plan';
    }
    else{
      return 'Wybierz prowadzącego aby wysiwetlić jego plan';
    }
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        appBar:  AppBar(
          title: const Center(child: Text('Plan Zajeć')),
        ),
        body:   
        Card(
          child:  Column(
            children: [
               Center(child: Text(functionstring(index))),
                const SizedBox(
                height: 30,
                width: 30,
               ),
                Center(child: Material(child: SearchButton(index: index)))]),
        ),
             drawer:  DrawerWidget(selectedIndex: index) ,                                     
      );
  }
}