import 'dart:convert';

List<Todo> todoFromJson(String str) =>
    List<Todo>.from(json.decode(str).map((x) => Todo.fromJson(x)));

String todoToJson(List<Todo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Todo {
  Todo({
    required this.id,
    required this.todo,
    required this.isCompleted,
  });

  int id;
  String todo;
  bool isCompleted;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"] as int,
        todo: json["todo"],
        isCompleted: json["isCompleted"] == "true",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "isCompleted": isCompleted,
      };
}
