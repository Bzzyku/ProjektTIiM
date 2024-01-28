import 'package:http/http.dart' as http;
import 'dart:convert';
class Timetable {
   const Timetable();

  
   final String baseUrl = "http://planwat.azurewebsites.net/polls";
   final String apiKey = 'karzel';

   

Future<Map<String, dynamic>> days() async {
    final String apiUrl = '$baseUrl/days' ;
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'key': apiKey,    
      },
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }
Future<Map<String, String>> lecturers() async {
    final String apiUrl = '$baseUrl/prow' ;
    final Map<String, String> headers = {'key': apiKey};
    try {
    final response = await http.get(Uri.parse(apiUrl), headers: headers);

  if (response.statusCode == 200) {
        final Map<String,String> data = Map<String,String>.from(json.decode(response.body));
        return data;
      } else {
        print("HTTP request failed with status: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to load data");
    }
  }

  Future<List<String>> group() async {
  final String apiUrl = "$baseUrl/grp";
  final Map<String, String> headers = {'key': apiKey};
  try {
    final response = await http.get(Uri.parse(apiUrl), headers: headers);

  if (response.statusCode == 200) {
        final List<String> data = List<String>.from(json.decode(response.body));
        return data;
      } else {
        print("HTTP request failed with status: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Failed to load data");
    }
  }
Future<Map<String, dynamic>> actualization() async {
    final String apiUrl = '$baseUrl/actuality/stud' ;
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'key': apiKey,    
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }

Future<Map<String, Map<String,List<String>>>> groupTimetable(String groupName) async {
    final String apiUrl = '$baseUrl/plan/stud' ;
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'key': apiKey,
        'grp' : groupName    
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }


Future<Map<String, dynamic>> lecturerTimetable(String lecturerId) async {
    final String apiUrl = '$baseUrl/grp' ;
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'key': apiKey,
        'prow': lecturerId,    
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }


}