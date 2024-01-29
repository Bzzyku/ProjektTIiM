import 'package:flutter/material.dart';
import 'package:flutter_application_1/Projekt/WelcomeScreen.dart';

class DrawerWidget extends StatefulWidget {
   const DrawerWidget({
    super.key,
    this.selectedIndex
    });

  final int? selectedIndex;

  @override
  State<DrawerWidget> createState() => _DrawerState();
}

class _DrawerState extends State<DrawerWidget> {
   

  void _onItemTapped( int index) {
    setState(() {
      
       Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  WelcomeScreen(index: index)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                       const DrawerHeader(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        child: Text('Menu'),
                        ),
                        ListTile(
                          title: const Text('Plan zajeć studenta'),
                          selected: widget.selectedIndex == 0,
                          onTap: () {
                            _onItemTapped(0);
                          }
                        ),
                        ListTile(
                          title: const Text('Plan zajeć prowadzącego'),
                          selected: widget.selectedIndex == 1,
                          onTap: () {
                            _onItemTapped(1);
                            
                          }
                        ),
                        
                    ],
                  ),
                 );

  }
}