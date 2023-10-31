import 'dart:convert';

class Tasks {
  List<Task> items = [];

  Tasks.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      final task = Task.fromJson(item);
      items.add(task);
    });
  }
}

Task taskFromJson(String str) => Task.fromJson(json.decode(str));
String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  String id;
  String title;
  String subtitle;
  String description;
  String start_date;
  String end_date;

  Task({
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.start_date,
    this.end_date,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["_id"],
        title: json["title"],
        subtitle: json["subtitle"],
        description: json["description"],
        start_date: json["start_date"],
        end_date: (json["end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "subtitle": subtitle,
        "description": description,
        "start_date": start_date,
        "end_date": end_date,
      };
}
