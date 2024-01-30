
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Projekt/Api_manager.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_application_1/Projekt/DayViewTimetable.dart';
import 'package:flutter_application_1/Projekt/getGroupsAndLecturers.dart';

class SearchButton extends StatefulWidget {
  const SearchButton({
    super.key,
    required this.index,
    });
    final int index;
    
  @override
  State<SearchButton> createState() => _SearchButtonState();
}

class _SearchButtonState extends State<SearchButton> {
  Timetable api = const Timetable();
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  GetGroupsAndLecturers getGroupsAndLecturers = GetGroupsAndLecturers();
  int x = 0;
  
  
    @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
}

  void navigateTo(String value){

      selectedValue = value;
            Navigator.push(
              context, 
              MaterialPageRoute(
                builder: (context) => DayViewTimetable(index: widget.index, group: value,)));

  }

 
  
  String functionstring(int value){
    if (value == 0)
    {
      return 'Wybierz Grupę';
      
    }
    else{
      return 'Wybierz prowadzącego';
    }
  }
  
  



@override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DropdownMenuItem<String>>>(
      future: getGroupsAndLecturers.fetchDataAndBuildItems(widget.index),
      builder: (BuildContext context,AsyncSnapshot<List<DropdownMenuItem<String>>> snapshot) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              functionstring(widget.index),
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: snapshot.data,
            value: selectedValue,
            onChanged: (value) {
              navigateTo(value!);
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 200,
            ),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 200,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
            ),
            dropdownSearchData: DropdownSearchData(
              searchController: textEditingController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Wyszukaj ',
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (items, searchValue) {
                return items.value.toString().contains(searchValue);
              },
            ),
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController.clear();
              }
            },
          ),
        );
      },
    );
  }
}