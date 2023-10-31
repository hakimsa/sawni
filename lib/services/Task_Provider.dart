import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Task.dart';

class Provider {
//Method to get all tasks
  String url = "http://192.168.0.24:8078/";
  bool isADD = false;

  Future<List<Task>> getTasks() async {
    try {
      final response = await http.get(Uri.parse(url + "all"));
      String responsebody = response.body;
      final int statusCode = response.statusCode;
      if (statusCode == 200 || statusCode == 201) {
        final items = json.decode(responsebody);
        final tasks = Tasks.fromJsonList(items['data']);
        return tasks.items;
      }
    } catch (e) {
      print("ERORR " + " =>  " + e.toString());
    }
    return [];
  }

  Future<Task> createTask(String title, String subtitle, String description,
      String startDate, String endDate) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.24:8078/add'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'start_date': startDate,
        'end_date': endDate
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      isADD = true;
      final task = Task.fromJson(jsonDecode(response.body));

      return task;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Task.');
    }
  }


  Future<Task> updateTask(String id,String title,String subtitle,String description,String startDate,String endDate) async {


    final response = await http.post(
      Uri.parse('http://192.168.0.24:8078/update/'+id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'start_date': startDate,
        'end_date': endDate
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.z
      return Task.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update Task.');
    }
  }



  Future<Task> deleteTask(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://192.168.0.24:8078/delete/'+id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON. After deleting,
      // you'll get an empty JSON `{}` response.
      // Don't return `null`, otherwise `snapshot.hasData`
      // will always return false on `FutureBuilder`.
      return Task.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete Task.');
    }
  }
}
