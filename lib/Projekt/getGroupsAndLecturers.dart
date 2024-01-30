import 'package:flutter/material.dart';
import 'package:flutter_application_1/Projekt/Api_manager.dart';

class GetGroupsAndLecturers {
  GetGroupsAndLecturers();

  List<String> groups = [];
  Map<String, String> lecturers = {};
  List<DropdownMenuItem<String>> savedLecturers = [];
  List<DropdownMenuItem<String>> savedGroup = [];
  Timetable api = const Timetable();
  List<dynamic> events = [];

  Future<void> fetchDataTimetable(String group) async {
    try {
      List<dynamic> apiData = await api.groupTimetable(group);
      events = apiData;
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> fetchDataGroup() async {
    try {
      List<String> apiData = await api.group();
      groups = apiData;
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> fetchDataGroupLecturers() async {
    try {
      Map<String, String> apiData = await api.lecturers();
      lecturers = apiData;
    } catch (e) {
      print("Error: $e");
    }
  }

  List<DropdownMenuItem<String>> convertListOfStringsToDropdownMenuItems(
      List<String> groups) {
    return groups.map((group) {
      return DropdownMenuItem<String>(
        value: group,
        child: Text(group,
            style: const TextStyle(
              fontSize: 14,
            )),
      );
    }).toList();
  }

  List<DropdownMenuItem<String>> convertMapOfStringsToDropdownMenuItems(
      Map<String, String> lecturers) {
    List<DropdownMenuItem<String>> result = [];

    lecturers.forEach((key, value) {
      result.add(DropdownMenuItem<String>(
        value: key,
        child: Text(value,
            style: const TextStyle(
              fontSize: 14,
            )),
      ));
    });

    return result;
  }

  Future<List<DropdownMenuItem<String>>> fetchDataAndBuildItems(
      int value) async {
    if (value == 0 && savedGroup.isEmpty) {
      await fetchDataGroup();
      return convertListOfStringsToDropdownMenuItems(groups);
    } else {
      await fetchDataGroupLecturers();
      return convertMapOfStringsToDropdownMenuItems(lecturers);
    }
  }
}
